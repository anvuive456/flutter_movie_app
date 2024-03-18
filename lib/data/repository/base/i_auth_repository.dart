import 'package:movie_app/domain/model/app_user.dart';

abstract interface class IAuthRepository {
  Future<AppUser?> getUser();

  Future<AppUser?> signUpWithEmailPassword(
      {required String email, required String password});

  Future<bool> signOut();

  Future<AppUser?>  signInWithEmailPassword(String email, String password);
}
