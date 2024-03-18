import 'package:injectable/injectable.dart';
import 'package:movie_app/core/firebase/firebase_auth_service.dart';
import 'package:movie_app/data/datasource/base/i_profile_datasource.dart';
import 'package:movie_app/domain/model/app_user.dart';

@Injectable(as: IProfileDataSource)
class FirebaseProfileDatasource implements IProfileDataSource {
  FirebaseProfileDatasource(this._service);

  final FirebaseAuthService _service;

  @override
  Future<AppUser> getProfile() async {
    final user = await _service.getUser();
    if (user == null) return const AppUser.empty();
    return AppUser.fromFirebaseUser(user);
  }

  @override
  Future<AppUser> updateProfile(AppUser newProfile) async {
    final user = await _service.updateUser(newProfile);
    if (user == null) return const AppUser.empty();
    return AppUser.fromFirebaseUser(user);
  }
}
