import '../../data/models/profile_model.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class ProfileLoading extends ProfileStates {}

class ProfileSuccess extends ProfileStates {
  final ProfileModel profile;
  ProfileSuccess(this.profile);
}

class ProfileError extends ProfileStates {
  final String errorMessage;
  ProfileError(this.errorMessage);
}
