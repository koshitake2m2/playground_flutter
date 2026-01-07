import 'package:riverpod/riverpod.dart';

import '../../domain/models/todo.dart';
import '../services/todo_local_service.dart';

abstract class TodoRepository {
  Stream<List<Todo>> watchTodos();
  Future<void> addTodo(String title);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(int id);
}

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._localService);

  final TodoLocalService _localService;

  @override
  Stream<List<Todo>> watchTodos() {
    return _localService.watchTodoRecords().map(
          (records) => records
              .map((record) => Todo(id: record.id, title: record.title))
              .toList(growable: false),
        );
  }

  @override
  Future<void> addTodo(String title) async {
    await _localService.insertTodoRecord(title);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await _localService.updateTodoRecord(todo.id, todo.title);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await _localService.deleteTodoRecord(id);
  }
}

final todoRepositoryProvider = Provider<TodoRepository>(
  (ref) => TodoRepositoryImpl(ref.watch(todoLocalServiceProvider)),
);
