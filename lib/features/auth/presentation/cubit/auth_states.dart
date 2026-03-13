abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthSuccess extends AuthStates {
  final String message;
  AuthSuccess(this.message);
}

class AuthError extends AuthStates {
  final String message;
  AuthError(this.message);
}
