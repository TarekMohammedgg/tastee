import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tastee/core/local/meals_dao.dart';
import 'package:tastee/features/favourite/presentation/cubit/favourite_states.dart';
import 'package:tastee/features/meals/data/models/meal_model.dart';

class FavouriteCubit extends Cubit<FavouriteStates> {
  final MealsDao _mealsDao;

  FavouriteCubit(this._mealsDao) : super(FavouriteInitial());

  String get _userId => Supabase.instance.client.auth.currentUser!.id;

  Future<void> loadFavourites() async {
    emit(FavouriteLoading());
    try {
      final meals = await _mealsDao.getUserMeals(_userId);
      final favourites = meals.map(MealModel.fromDrift).toList();
      emit(FavouriteUpdated(favourites));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<void> toggleFavourite(MealModel meal) async {
    try {
      final exists = await _mealsDao.getMealById(meal.idMeal ?? '', _userId);
      if (exists != null) {
        await _mealsDao.deleteMeal(meal.idMeal ?? '', _userId);
      } else {
        await _mealsDao.insertMeal(meal.toCompanion(_userId));
      }
      await loadFavourites();
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  bool isFavourite(String? mealId) {
    if (mealId == null) return false;
    return getFavourites().any((m) => m.idMeal == mealId);
  }

  List<MealModel> getFavourites() {
    final currentState = state;
    if (currentState is FavouriteUpdated) {
      return currentState.favourites;
    }
    return [];
  }
}
