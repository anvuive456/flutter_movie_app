import '../../../domain/model/app_user.dart';

abstract interface class IProfileRepository {
  Future<AppUser> getProfile();

  Future<AppUser> updateProfile(AppUser newProfile);
}
