import 'package:dartz/dartz.dart';
import 'package:tastee/core/constants/api_consts.dart';
import 'package:tastee/core/networking/dio_helper.dart';
import 'package:tastee/features/meals/data/models/meal_model.dart';

class MealsRepo {
  Future<Either<String, List<MealModel>>> getMeals(String categoryName) async {
    try {
      final response = await DioHelper.get(
        endpoint: ApiConsts.getMeal(categoryName),
      );
      final data = response.data['meals'];
      final meals = (data as List)
          .map((e) => MealModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return right(meals);
    } catch (e) {
      return left(e.toString());
    }
  }
}
