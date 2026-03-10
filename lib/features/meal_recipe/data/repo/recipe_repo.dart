import 'package:dartz/dartz.dart';
import 'package:tastee/core/constants/api_consts.dart';
import 'package:tastee/core/networking/dio_helper.dart';
import 'package:tastee/features/meal_recipe/data/models/recipe_model.dart';

class RecipeRepo {
  Future<Either<String, RecipeModel>> getRecipeDetails(String mealId) async {
    try {
      final response = await DioHelper.get(
        endpoint: ApiConsts.getMealDetails(mealId),
      );
      final data = response.data['meals'];
      if (data != null && data.isNotEmpty) {
        final recipe = RecipeModel.fromJson(data[0] as Map<String, dynamic>);
        return right(recipe);
      } else {
        return left("Recipe not found");
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
