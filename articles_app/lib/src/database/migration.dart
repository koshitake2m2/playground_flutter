import 'package:articles_app/src/database/posts_dao.dart';
import 'package:drift/drift.dart';

part 'migration.g.dart';

@DataClassName('Author')
class Authors extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

@DataClassName('Post')
class Posts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
}

@DriftDatabase(tables: [Authors, Posts], daos: [PostsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (m) async {
      // テーブル作成
      await m.createAll();

      await into(authors).insert(AuthorsCompanion.insert(name: 'koshitake2m2'));
      await into(posts).insert(PostsCompanion.insert(title: 'Hello World!'));
    });
  }
}
