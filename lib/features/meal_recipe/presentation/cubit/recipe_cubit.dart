import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastee/features/meal_recipe/data/repo/recipe_repo.dart';
import 'recipe_states.dart';

class RecipeCubit extends Cubit<RecipeStates> {
  RecipeCubit() : super(RecipeInitial());

  final repo = RecipeRepo();

  void getRecipe(String mealId) async {
    emit(RecipeLoading());
    final result = await repo.getRecipeDetails(mealId);

    result.fold(
      (error) => emit(RecipeError(error)),
      (recipe) => emit(RecipeSuccess(recipe)),
    );
  }
}
