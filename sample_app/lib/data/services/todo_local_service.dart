import 'package:riverpod/riverpod.dart';

import '../db/app_database.dart';

abstract class TodoLocalService {
  Stream<List<TodoRecord>> watchTodoRecords();
  Future<int> insertTodoRecord(String title);
  Future<void> updateTodoRecord(int id, String title);
  Future<void> deleteTodoRecord(int id);
}

class DriftTodoLocalService implements TodoLocalService {
  DriftTodoLocalService(this._db);

  final AppDatabase _db;

  @override
  Stream<List<TodoRecord>> watchTodoRecords() {
    return _db.watchTodos();
  }

  @override
  Future<int> insertTodoRecord(String title) {
    return _db.insertTodo(title);
  }

  @override
  Future<void> updateTodoRecord(int id, String title) async {
    await _db.updateTodo(id, title);
  }

  @override
  Future<void> deleteTodoRecord(int id) async {
    await _db.deleteTodo(id);
  }
}

final todoLocalServiceProvider = Provider<TodoLocalService>(
  (ref) => DriftTodoLocalService(ref.watch(appDatabaseProvider)),
);
