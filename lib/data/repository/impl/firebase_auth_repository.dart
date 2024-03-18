import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/firebase/firebase_auth_service.dart';
import 'package:movie_app/data/repository/base/i_auth_repository.dart';
import 'package:movie_app/domain/model/app_user.dart';

@Injectable(as: IAuthRepository)
class FirebaseAuthRepository implements IAuthRepository {
  FirebaseAuthRepository(this.authService);

  final FirebaseAuthService authService;

  @override
  Future<AppUser?> getUser() async {
    final firebaseUser = await authService.getUser();
    if (firebaseUser == null) return null;
    return AppUser.fromFirebaseUser(firebaseUser);
  }

  @override
  Future<AppUser?> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final cred = await authService.signUpWithEmailPassword(
          email: email, password: password);
      if (cred.user == null) return null;
      return AppUser.fromFirebaseUser(cred.user!);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await authService.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<AppUser?> signInWithEmailPassword(
      String email, String password) async {
    try {
      final cred = await authService.signIn(
          credential:
              EmailAuthProvider.credential(email: email, password: password));

      if (cred.user == null) return null;

      return AppUser.fromFirebaseUser(cred.user!);
    } catch (e) {
      return Future.error(e);
    }
  }
}
