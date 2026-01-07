// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TodoRecordsTable extends TodoRecords
    with TableInfo<$TodoRecordsTable, TodoRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
    );
  }

  @override
  $TodoRecordsTable createAlias(String alias) {
    return $TodoRecordsTable(attachedDatabase, alias);
  }
}

class TodoRecord extends DataClass implements Insertable<TodoRecord> {
  final int id;
  final String title;
  const TodoRecord({required this.id, required this.title});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    return map;
  }

  TodoRecordsCompanion toCompanion(bool nullToAbsent) {
    return TodoRecordsCompanion(id: Value(id), title: Value(title));
  }

  factory TodoRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoRecord(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
    };
  }

  TodoRecord copyWith({int? id, String? title}) =>
      TodoRecord(id: id ?? this.id, title: title ?? this.title);
  TodoRecord copyWithCompanion(TodoRecordsCompanion data) {
    return TodoRecord(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoRecord(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoRecord && other.id == this.id && other.title == this.title);
}

class TodoRecordsCompanion extends UpdateCompanion<TodoRecord> {
  final Value<int> id;
  final Value<String> title;
  const TodoRecordsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
  });
  TodoRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
  }) : title = Value(title);
  static Insertable<TodoRecord> custom({
    Expression<int>? id,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
    });
  }

  TodoRecordsCompanion copyWith({Value<int>? id, Value<String>? title}) {
    return TodoRecordsCompanion(id: id ?? this.id, title: title ?? this.title);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoRecordsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TodoRecordsTable todoRecords = $TodoRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoRecords];
}

typedef $$TodoRecordsTableCreateCompanionBuilder =
    TodoRecordsCompanion Function({Value<int> id, required String title});
typedef $$TodoRecordsTableUpdateCompanionBuilder =
    TodoRecordsCompanion Function({Value<int> id, Value<String> title});

class $$TodoRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $TodoRecordsTable> {
  $$TodoRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TodoRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $TodoRecordsTable> {
  $$TodoRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TodoRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TodoRecordsTable> {
  $$TodoRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);
}

class $$TodoRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TodoRecordsTable,
          TodoRecord,
          $$TodoRecordsTableFilterComposer,
          $$TodoRecordsTableOrderingComposer,
          $$TodoRecordsTableAnnotationComposer,
          $$TodoRecordsTableCreateCompanionBuilder,
          $$TodoRecordsTableUpdateCompanionBuilder,
          (
            TodoRecord,
            BaseReferences<_$AppDatabase, $TodoRecordsTable, TodoRecord>,
          ),
          TodoRecord,
          PrefetchHooks Function()
        > {
  $$TodoRecordsTableTableManager(_$AppDatabase db, $TodoRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodoRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodoRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodoRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
              }) => TodoRecordsCompanion(id: id, title: title),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String title}) =>
                  TodoRecordsCompanion.insert(id: id, title: title),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TodoRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TodoRecordsTable,
      TodoRecord,
      $$TodoRecordsTableFilterComposer,
      $$TodoRecordsTableOrderingComposer,
      $$TodoRecordsTableAnnotationComposer,
      $$TodoRecordsTableCreateCompanionBuilder,
      $$TodoRecordsTableUpdateCompanionBuilder,
      (
        TodoRecord,
        BaseReferences<_$AppDatabase, $TodoRecordsTable, TodoRecord>,
      ),
      TodoRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TodoRecordsTableTableManager get todoRecords =>
      $$TodoRecordsTableTableManager(_db, _db.todoRecords);
}
