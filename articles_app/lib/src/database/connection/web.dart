import 'package:drift/backends.dart';
import 'package:drift/web.dart';

QueryExecutor constructDb() {
  return WebDatabase('db');
}
