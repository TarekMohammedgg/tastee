import 'package:dartz/dartz.dart';
import 'package:tastee/core/constants/api_consts.dart';
import 'package:tastee/core/networking/dio_helper.dart';
import 'package:tastee/features/home/data/models/category_model.dart';

class HomeRepo {
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final response = await DioHelper.get(endpoint: ApiConsts.getCategories());
      final data = response.data['categories'];
      final categories = (data as List)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return right(categories);
    } catch (e) {
      return left(e.toString());
    }
  }
}
