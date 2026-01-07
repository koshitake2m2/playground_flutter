import 'dart:async';

import 'package:sample_app/data/repositories/todo_repository.dart';
import 'package:sample_app/domain/models/todo.dart';

class FakeTodoRepository implements TodoRepository {
  final _controller = StreamController<List<Todo>>.broadcast();
  final List<Todo> _todos = [];
  int _nextId = 1;

  void dispose() {
    _controller.close();
  }

  @override
  Stream<List<Todo>> watchTodos() => _controller.stream;

  @override
  Future<void> addTodo(String title) async {
    _todos.add(Todo(id: _nextId++, title: title));
    _controller.add(List.unmodifiable(_todos));
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final index = _todos.indexWhere((item) => item.id == todo.id);
    if (index == -1) {
      return;
    }
    _todos[index] = todo;
    _controller.add(List.unmodifiable(_todos));
  }

  @override
  Future<void> deleteTodo(int id) async {
    _todos.removeWhere((item) => item.id == id);
    _controller.add(List.unmodifiable(_todos));
  }
}
