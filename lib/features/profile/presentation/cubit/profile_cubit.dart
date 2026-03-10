import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/profile_repo.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());

  final repo = ProfileRepo();

  void getProfile() async {
    emit(ProfileLoading());
    final result = await repo.getUserProfile();

    result.fold(
      (error) => emit(ProfileError(error)),
      (profile) => emit(ProfileSuccess(profile)),
    );
  }
}
