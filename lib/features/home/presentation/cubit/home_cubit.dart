import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastee/features/home/data/repo/home_repo.dart';
import 'package:tastee/features/home/presentation/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());

  Future<void> getCategories() async {
    emit(HomeLoading());
    try {
      final categories = await HomeRepo().getCategories();
      categories.fold(
        (failure) {
          emit(HomeError(errorMessage: failure));
        },
        (categories) {
          emit(HomeSuccess(categories: categories));
        },
      );
    } catch (e) {
      emit(HomeError(errorMessage: e.toString()));
    }
  }
}
