import 'package:articles_app/src/database/migration.dart';
import 'package:articles_app/src/database/posts_dao.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './connection/connection.dart' as connection;

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase(connection.constructDb());
});

final postsDaoProvider = Provider<PostsDao>((ref) {
  return PostsDao(ref.read(databaseProvider));
});

FutureProvider<void> closeDatabaseProvider = FutureProvider((ref) async {
  final database = ref.read(databaseProvider);
  await database.close();
});
