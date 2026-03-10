import 'package:tastee/features/meal_recipe/data/models/recipe_model.dart';

abstract class RecipeStates {}

class RecipeInitial extends RecipeStates {}

class RecipeLoading extends RecipeStates {}

class RecipeSuccess extends RecipeStates {
  final RecipeModel recipe;
  RecipeSuccess(this.recipe);
}

class RecipeError extends RecipeStates {
  final String errorMessage;
  RecipeError(this.errorMessage);
}
