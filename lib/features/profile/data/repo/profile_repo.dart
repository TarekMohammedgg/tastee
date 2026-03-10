import 'package:dartz/dartz.dart';
import '../models/profile_model.dart';

class ProfileRepo {
  Future<Either<String, ProfileModel>> getUserProfile() async {
    // Mock user profile data since backend for profile doesn't exist yet
    await Future.delayed(const Duration(seconds: 1));
    return right(
      ProfileModel(
        name: "Alex Johnson",
        email: "alex.j@example.com",
        avatarUrl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
      ),
    );
  }
}
