import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  final SupabaseClient _client = Supabase.instance.client;

  Future<Either<String, User>> signIn({required String email, required String password}) async {
    try {
      final response = await _client.auth.signInWithPassword(email: email, password: password);
      if (response.user != null) {
        return Right(response.user!);
      }
      return const Left("Login failed. No user returned.");
    } on AuthException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, User>> signUp({required String email, required String password}) async {
    try {
      final response = await _client.auth.signUp(email: email, password: password);
      if (response.user != null) {
        return Right(response.user!);
      }
      return const Left("Sign up failed. No user returned.");
    } on AuthException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<Either<String, User>> signInWithGoogle() async {
    try {
      const webClientId =
          '939811805184-618evq32bsd57cbf20b58f8o2cbepgm9.apps.googleusercontent.com';

      // google_sign_in 7.x uses a singleton; initialize() must be called before signIn().
      await GoogleSignIn.instance.initialize(serverClientId: webClientId);

      // 7.x: authenticate() replaces signIn(); throws on cancel instead of returning null.
      final googleUser = await GoogleSignIn.instance.authenticate();

      // 7.x: authentication is synchronous and only exposes idToken (no accessToken).
      final idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        return const Left('No ID Token found.');
      }

      final response = await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );

      if (response.user != null) {
        return Right(response.user!);
      }
      return const Left("Google Sign-In failed. No user returned.");
    } on AuthException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  User? getCurrentUser() {
    return _client.auth.currentUser;
  }
}
