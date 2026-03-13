import 'package:drift/drift.dart';
import 'package:tastee/core/local/app_database.dart';

class MealModel {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  MealModel({this.strMeal, this.strMealThumb, this.idMeal});

  MealModel.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
  }

  // ── Drift ───────────────────────────────────────────────

  /// Convert API model → Drift Companion (for insert/update)
  MealsCompanion toCompanion(String userId) => MealsCompanion(
        idMeal: Value(idMeal ?? ''),
        userId: Value(userId),
        strMeal: Value(strMeal),
        strMealThumb: Value(strMealThumb),
      );

  /// Convert Drift row → MealModel (for use in your app)
  factory MealModel.fromDrift(Meal drift) => MealModel(
        idMeal: drift.idMeal,
        strMeal: drift.strMeal,
        strMealThumb: drift.strMealThumb,
      );
}