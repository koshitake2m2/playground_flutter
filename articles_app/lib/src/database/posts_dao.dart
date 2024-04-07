import 'package:articles_app/src/database/migration.dart';
import 'package:drift/drift.dart';

part 'posts_dao.g.dart';

@DriftAccessor(tables: [Posts])
class PostsDao extends DatabaseAccessor<AppDatabase> with _$PostsDaoMixin {
  PostsDao(super.db);

  Future<List<Post>> getAll() => select(posts).get();
  Stream<List<Post>> getAllStream() => select(posts).watch();
}
