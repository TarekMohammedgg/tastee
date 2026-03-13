// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MealsTable extends Meals with TableInfo<$MealsTable, Meal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMealMeta = const VerificationMeta('idMeal');
  @override
  late final GeneratedColumn<String> idMeal = GeneratedColumn<String>(
    'id_meal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strMealMeta = const VerificationMeta(
    'strMeal',
  );
  @override
  late final GeneratedColumn<String> strMeal = GeneratedColumn<String>(
    'str_meal',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _strMealThumbMeta = const VerificationMeta(
    'strMealThumb',
  );
  @override
  late final GeneratedColumn<String> strMealThumb = GeneratedColumn<String>(
    'str_meal_thumb',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [idMeal, userId, strMeal, strMealThumb];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Meal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_meal')) {
      context.handle(
        _idMealMeta,
        idMeal.isAcceptableOrUnknown(data['id_meal']!, _idMealMeta),
      );
    } else if (isInserting) {
      context.missing(_idMealMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('str_meal')) {
      context.handle(
        _strMealMeta,
        strMeal.isAcceptableOrUnknown(data['str_meal']!, _strMealMeta),
      );
    }
    if (data.containsKey('str_meal_thumb')) {
      context.handle(
        _strMealThumbMeta,
        strMealThumb.isAcceptableOrUnknown(
          data['str_meal_thumb']!,
          _strMealThumbMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idMeal, userId};
  @override
  Meal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Meal(
      idMeal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_meal'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      strMeal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}str_meal'],
      ),
      strMealThumb: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}str_meal_thumb'],
      ),
    );
  }

  @override
  $MealsTable createAlias(String alias) {
    return $MealsTable(attachedDatabase, alias);
  }
}

class Meal extends DataClass implements Insertable<Meal> {
  final String idMeal;
  final String userId;
  final String? strMeal;
  final String? strMealThumb;
  const Meal({
    required this.idMeal,
    required this.userId,
    this.strMeal,
    this.strMealThumb,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_meal'] = Variable<String>(idMeal);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || strMeal != null) {
      map['str_meal'] = Variable<String>(strMeal);
    }
    if (!nullToAbsent || strMealThumb != null) {
      map['str_meal_thumb'] = Variable<String>(strMealThumb);
    }
    return map;
  }

  MealsCompanion toCompanion(bool nullToAbsent) {
    return MealsCompanion(
      idMeal: Value(idMeal),
      userId: Value(userId),
      strMeal: strMeal == null && nullToAbsent
          ? const Value.absent()
          : Value(strMeal),
      strMealThumb: strMealThumb == null && nullToAbsent
          ? const Value.absent()
          : Value(strMealThumb),
    );
  }

  factory Meal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Meal(
      idMeal: serializer.fromJson<String>(json['idMeal']),
      userId: serializer.fromJson<String>(json['userId']),
      strMeal: serializer.fromJson<String?>(json['strMeal']),
      strMealThumb: serializer.fromJson<String?>(json['strMealThumb']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idMeal': serializer.toJson<String>(idMeal),
      'userId': serializer.toJson<String>(userId),
      'strMeal': serializer.toJson<String?>(strMeal),
      'strMealThumb': serializer.toJson<String?>(strMealThumb),
    };
  }

  Meal copyWith({
    String? idMeal,
    String? userId,
    Value<String?> strMeal = const Value.absent(),
    Value<String?> strMealThumb = const Value.absent(),
  }) => Meal(
    idMeal: idMeal ?? this.idMeal,
    userId: userId ?? this.userId,
    strMeal: strMeal.present ? strMeal.value : this.strMeal,
    strMealThumb: strMealThumb.present ? strMealThumb.value : this.strMealThumb,
  );
  Meal copyWithCompanion(MealsCompanion data) {
    return Meal(
      idMeal: data.idMeal.present ? data.idMeal.value : this.idMeal,
      userId: data.userId.present ? data.userId.value : this.userId,
      strMeal: data.strMeal.present ? data.strMeal.value : this.strMeal,
      strMealThumb: data.strMealThumb.present
          ? data.strMealThumb.value
          : this.strMealThumb,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Meal(')
          ..write('idMeal: $idMeal, ')
          ..write('userId: $userId, ')
          ..write('strMeal: $strMeal, ')
          ..write('strMealThumb: $strMealThumb')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idMeal, userId, strMeal, strMealThumb);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Meal &&
          other.idMeal == this.idMeal &&
          other.userId == this.userId &&
          other.strMeal == this.strMeal &&
          other.strMealThumb == this.strMealThumb);
}

class MealsCompanion extends UpdateCompanion<Meal> {
  final Value<String> idMeal;
  final Value<String> userId;
  final Value<String?> strMeal;
  final Value<String?> strMealThumb;
  final Value<int> rowid;
  const MealsCompanion({
    this.idMeal = const Value.absent(),
    this.userId = const Value.absent(),
    this.strMeal = const Value.absent(),
    this.strMealThumb = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealsCompanion.insert({
    required String idMeal,
    required String userId,
    this.strMeal = const Value.absent(),
    this.strMealThumb = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : idMeal = Value(idMeal),
       userId = Value(userId);
  static Insertable<Meal> custom({
    Expression<String>? idMeal,
    Expression<String>? userId,
    Expression<String>? strMeal,
    Expression<String>? strMealThumb,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (idMeal != null) 'id_meal': idMeal,
      if (userId != null) 'user_id': userId,
      if (strMeal != null) 'str_meal': strMeal,
      if (strMealThumb != null) 'str_meal_thumb': strMealThumb,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealsCompanion copyWith({
    Value<String>? idMeal,
    Value<String>? userId,
    Value<String?>? strMeal,
    Value<String?>? strMealThumb,
    Value<int>? rowid,
  }) {
    return MealsCompanion(
      idMeal: idMeal ?? this.idMeal,
      userId: userId ?? this.userId,
      strMeal: strMeal ?? this.strMeal,
      strMealThumb: strMealThumb ?? this.strMealThumb,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idMeal.present) {
      map['id_meal'] = Variable<String>(idMeal.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (strMeal.present) {
      map['str_meal'] = Variable<String>(strMeal.value);
    }
    if (strMealThumb.present) {
      map['str_meal_thumb'] = Variable<String>(strMealThumb.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealsCompanion(')
          ..write('idMeal: $idMeal, ')
          ..write('userId: $userId, ')
          ..write('strMeal: $strMeal, ')
          ..write('strMealThumb: $strMealThumb, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MealsTable meals = $MealsTable(this);
  late final MealsDao mealsDao = MealsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [meals];
}

typedef $$MealsTableCreateCompanionBuilder =
    MealsCompanion Function({
      required String idMeal,
      required String userId,
      Value<String?> strMeal,
      Value<String?> strMealThumb,
      Value<int> rowid,
    });
typedef $$MealsTableUpdateCompanionBuilder =
    MealsCompanion Function({
      Value<String> idMeal,
      Value<String> userId,
      Value<String?> strMeal,
      Value<String?> strMealThumb,
      Value<int> rowid,
    });

class $$MealsTableFilterComposer extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get idMeal => $composableBuilder(
    column: $table.idMeal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strMeal => $composableBuilder(
    column: $table.strMeal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strMealThumb => $composableBuilder(
    column: $table.strMealThumb,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MealsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get idMeal => $composableBuilder(
    column: $table.idMeal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strMeal => $composableBuilder(
    column: $table.strMeal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strMealThumb => $composableBuilder(
    column: $table.strMealThumb,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get idMeal =>
      $composableBuilder(column: $table.idMeal, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get strMeal =>
      $composableBuilder(column: $table.strMeal, builder: (column) => column);

  GeneratedColumn<String> get strMealThumb => $composableBuilder(
    column: $table.strMealThumb,
    builder: (column) => column,
  );
}

class $$MealsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealsTable,
          Meal,
          $$MealsTableFilterComposer,
          $$MealsTableOrderingComposer,
          $$MealsTableAnnotationComposer,
          $$MealsTableCreateCompanionBuilder,
          $$MealsTableUpdateCompanionBuilder,
          (Meal, BaseReferences<_$AppDatabase, $MealsTable, Meal>),
          Meal,
          PrefetchHooks Function()
        > {
  $$MealsTableTableManager(_$AppDatabase db, $MealsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> idMeal = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> strMeal = const Value.absent(),
                Value<String?> strMealThumb = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealsCompanion(
                idMeal: idMeal,
                userId: userId,
                strMeal: strMeal,
                strMealThumb: strMealThumb,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String idMeal,
                required String userId,
                Value<String?> strMeal = const Value.absent(),
                Value<String?> strMealThumb = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealsCompanion.insert(
                idMeal: idMeal,
                userId: userId,
                strMeal: strMeal,
                strMealThumb: strMealThumb,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MealsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealsTable,
      Meal,
      $$MealsTableFilterComposer,
      $$MealsTableOrderingComposer,
      $$MealsTableAnnotationComposer,
      $$MealsTableCreateCompanionBuilder,
      $$MealsTableUpdateCompanionBuilder,
      (Meal, BaseReferences<_$AppDatabase, $MealsTable, Meal>),
      Meal,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MealsTableTableManager get meals =>
      $$MealsTableTableManager(_db, _db.meals);
}
