import 'package:tastee/features/meals/data/models/meal_model.dart';

abstract class FavouriteStates {}

class FavouriteInitial extends FavouriteStates {}

class FavouriteLoading extends FavouriteStates {}

class FavouriteUpdated extends FavouriteStates {
  final List<MealModel> favourites;
  FavouriteUpdated(this.favourites);
}

class FavouriteError extends FavouriteStates {
  final String message;
  FavouriteError(this.message);
}
