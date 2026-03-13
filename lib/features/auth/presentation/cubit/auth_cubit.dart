import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/auth_repo.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await _authRepo.signIn(email: email, password: password);
    result.fold(
      (error) => emit(AuthError(error)),
      (_) => emit(AuthSuccess("Login successful!")),
    );
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await _authRepo.signUp(email: email, password: password);
    result.fold(
      (error) => emit(AuthError(error)),
      (_) => emit(AuthSuccess("Signup successful!")),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    final result = await _authRepo.signInWithGoogle();
    result.fold(
      (error) => emit(AuthError(error)),
      (_) => emit(AuthSuccess("Google Sign-In successful!")),
    );
  }

  Future<void> signOut() async {
    await _authRepo.signOut();
    emit(AuthInitial());
  }
}
