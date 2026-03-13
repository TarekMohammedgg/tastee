import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:tastee/core/local/meal_table.dart';
import 'package:tastee/core/local/meals_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Meals], daos: [MealsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.deleteTable('meals');
            await migrator.createAll();
          }
        },
      );

  static QueryExecutor _openConnection() =>
      driftDatabase(name: 'app_db');
}
