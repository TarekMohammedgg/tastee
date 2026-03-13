import 'package:drift/drift.dart';

class Meals extends Table {
  TextColumn get idMeal => text()();
  TextColumn get userId => text()();
  TextColumn get strMeal => text().nullable()();
  TextColumn get strMealThumb => text().nullable()();
  @override
  Set<Column> get primaryKey => {idMeal, userId};
}
