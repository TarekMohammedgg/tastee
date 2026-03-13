import 'package:drift/drift.dart';
import 'package:tastee/core/local/app_database.dart';
import 'package:tastee/core/local/meal_table.dart';

part 'meals_dao.g.dart';

@DriftAccessor(tables: [Meals])
class MealsDao extends DatabaseAccessor<AppDatabase> with _$MealsDaoMixin {
  MealsDao(super.db);

  // Watch all meals for a specific user
  Stream<List<Meal>> watchUserMeals(String userId) =>
      (select(meals)..where((m) => m.userId.equals(userId))).watch();

  // Get all meals for a specific user
  Future<List<Meal>> getUserMeals(String userId) =>
      (select(meals)..where((m) => m.userId.equals(userId))).get();

  // Insert or replace (upsert)
  Future<void> insertMeal(MealsCompanion entry) =>
      into(meals).insertOnConflictUpdate(entry);

  // Delete one meal by id and userId
  Future<int> deleteMeal(String id, String userId) =>
      (delete(meals)
            ..where(
                (m) => m.idMeal.equals(id) & m.userId.equals(userId)))
          .go();

  // Get one meal by id and userId
  Future<Meal?> getMealById(String id, String userId) =>
      (select(meals)
            ..where(
                (m) => m.idMeal.equals(id) & m.userId.equals(userId)))
          .getSingleOrNull();
}
