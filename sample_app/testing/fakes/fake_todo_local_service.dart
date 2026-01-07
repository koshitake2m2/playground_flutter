import 'dart:async';

import 'package:sample_app/data/db/app_database.dart';
import 'package:sample_app/data/services/todo_local_service.dart';

class FakeTodoLocalService implements TodoLocalService {
  final _controller = StreamController<List<TodoRecord>>.broadcast();
  final List<TodoRecord> _records = [];
  int _nextId = 1;

  void dispose() {
    _controller.close();
  }

  @override
  Stream<List<TodoRecord>> watchTodoRecords() {
    return _controller.stream;
  }

  @override
  Future<int> insertTodoRecord(String title) async {
    final record = TodoRecord(id: _nextId++, title: title);
    _records.add(record);
    _controller.add(List.unmodifiable(_records));
    return record.id;
  }

  @override
  Future<void> updateTodoRecord(int id, String title) async {
    final index = _records.indexWhere((record) => record.id == id);
    if (index == -1) {
      return;
    }
    _records[index] = TodoRecord(id: id, title: title);
    _controller.add(List.unmodifiable(_records));
  }

  @override
  Future<void> deleteTodoRecord(int id) async {
    _records.removeWhere((record) => record.id == id);
    _controller.add(List.unmodifiable(_records));
  }
}
