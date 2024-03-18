import 'package:movie_app/domain/model/app_user.dart';

abstract interface class IProfileDataSource {
  Future<AppUser> getProfile();

  Future<AppUser> updateProfile(AppUser newProfile);

}