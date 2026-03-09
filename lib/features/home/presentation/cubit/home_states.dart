import 'package:tastee/features/home/data/models/category_model.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSuccess extends HomeStates {
  final List<CategoryModel> categories;
  HomeSuccess({required this.categories});
}

class HomeError extends HomeStates {
  final String errorMessage;
  HomeError({required this.errorMessage});
}
