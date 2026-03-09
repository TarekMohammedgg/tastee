import 'package:tastee/features/meals/data/models/meal_model.dart';

abstract class MealsStates {}

class MealsInitial extends MealsStates {}

class MealsLoading extends MealsStates {}

class MealsSuccess extends MealsStates {
  final List<MealModel> meals;
  MealsSuccess({required this.meals});
}

class MealsError extends MealsStates {
  final String errorMessage;
  MealsError({required this.errorMessage});
}
