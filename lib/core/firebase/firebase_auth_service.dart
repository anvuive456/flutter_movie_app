import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/model/app_user.dart';

@singleton
class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> getUser() async => _auth.currentUser;

  Future<UserCredential> signIn({required AuthCredential credential}) async {
    return await _auth.signInWithCredential(credential);
  }

  Future<UserCredential> signUpWithEmailPassword(
      {required String email, required String password}) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<User?> updateUser(AppUser user) async {
    if (user.fullName != _auth.currentUser?.displayName) {
      await _auth.currentUser?.updateDisplayName(user.fullName);
    }
    if (user.avatarUrl != _auth.currentUser?.photoURL) {
      await _auth.currentUser?.updatePhotoURL(user.avatarUrl);
    }
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
