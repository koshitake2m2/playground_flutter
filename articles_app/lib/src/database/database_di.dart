import 'package:articles_app/src/database/migration.dart';
import 'package:articles_app/src/database/posts_dao.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final postsDaoProvider = Provider<PostsDao>((ref) {
  return PostsDao(ref.read(databaseProvider));
});
