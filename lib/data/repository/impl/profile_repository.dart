import 'package:injectable/injectable.dart';
import 'package:movie_app/data/datasource/base/i_profile_datasource.dart';
import 'package:movie_app/data/repository/base/i_profile_repository.dart';
import 'package:movie_app/domain/model/app_user.dart';

@Injectable(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  ProfileRepository(this.dataSource);

  final IProfileDataSource dataSource;

  @override
  Future<AppUser> getProfile() => dataSource.getProfile();

  @override
  Future<AppUser> updateProfile(AppUser newProfile) =>
      dataSource.updateProfile(newProfile);
}
