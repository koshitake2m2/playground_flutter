import 'package:drift/drift.dart';

class TodoRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
}
