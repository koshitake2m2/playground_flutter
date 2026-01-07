import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod/riverpod.dart';

import 'todo_tables.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'sample_app.db'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [TodoRecords])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<TodoRecord>> watchTodos() {
    return select(todoRecords).watch();
  }

  Future<int> insertTodo(String title) {
    return into(todoRecords).insert(TodoRecordsCompanion.insert(title: title));
  }

  Future<int> updateTodo(int id, String title) {
    return (update(todoRecords)..where((row) => row.id.equals(id)))
        .write(TodoRecordsCompanion(title: Value(title)));
  }

  Future<int> deleteTodo(int id) {
    return (delete(todoRecords)..where((row) => row.id.equals(id))).go();
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
