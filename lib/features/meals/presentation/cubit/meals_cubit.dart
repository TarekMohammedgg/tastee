import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastee/features/meals/data/repo/meals_repo.dart';
import 'package:tastee/features/meals/presentation/cubit/meals_states.dart';

class MealsCubit extends Cubit<MealsStates> {
  MealsCubit() : super(MealsInitial());

  Future<void> getMeals(String categoryName) async {
    emit(MealsLoading());
    try {
      final result = await MealsRepo().getMeals(categoryName);
      result.fold(
        (failure) => emit(MealsError(errorMessage: failure)),
        (meals) => emit(MealsSuccess(meals: meals)),
      );
    } catch (e) {
      emit(MealsError(errorMessage: e.toString()));
    }
  }
}
