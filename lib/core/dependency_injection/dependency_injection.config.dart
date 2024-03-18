// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/datasource/base/i_movie_datasource.dart' as _i8;
import '../../data/datasource/base/i_profile_datasource.dart' as _i12;
import '../../data/datasource/base/i_wishlist_datasource.dart' as _i16;
import '../../data/datasource/local/local_movie_datasource.dart' as _i17;
import '../../data/datasource/remote/api_movie_datasource.dart' as _i9;
import '../../data/datasource/remote/firebase_profile_datasource.dart' as _i13;
import '../../data/repository/base/i_auth_repository.dart' as _i6;
import '../../data/repository/base/i_movie_repository.dart' as _i10;
import '../../data/repository/base/i_profile_repository.dart' as _i14;
import '../../data/repository/base/i_wishlist_repository.dart' as _i18;
import '../../data/repository/impl/firebase_auth_repository.dart' as _i7;
import '../../data/repository/impl/mock_movie_repository.dart' as _i20;
import '../../data/repository/impl/movies_repository.dart' as _i11;
import '../../data/repository/impl/profile_repository.dart' as _i15;
import '../../data/repository/impl/wishlist_repository.dart' as _i19;
import '../../presentation/auth/bloc/auth_cubit.dart' as _i25;
import '../../presentation/movie/bloc/all_movies_cubit.dart' as _i23;
import '../../presentation/profile/bloc/profile_cubit.dart' as _i21;
import '../../presentation/wishlist/bloc/all_wishlist_cubit.dart' as _i24;
import '../../presentation/wishlist/bloc/check_wishlist_cubit.dart' as _i22;
import '../db/hive_service.dart' as _i5;
import '../firebase/firebase_auth_service.dart' as _i4;
import '../network/api_provider.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.ApiProvider>(() => _i3.ApiProvider()..init());
    gh.singleton<_i4.FirebaseAuthService>(() => _i4.FirebaseAuthService());
    await gh.factoryAsync<_i5.HiveService>(
      () {
        final i = _i5.HiveService();
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.factory<_i6.IAuthRepository>(
        () => _i7.FirebaseAuthRepository(gh<_i4.FirebaseAuthService>()));
    gh.factory<_i8.IMovieDatasource>(
        () => _i9.ApiMovieDatasource(gh<_i3.ApiProvider>()));
    gh.factory<_i10.IMovieRepository>(
        () => _i11.MoviesRepository(gh<_i8.IMovieDatasource>()));
    gh.factory<_i12.IProfileDataSource>(
        () => _i13.FirebaseProfileDatasource(gh<_i4.FirebaseAuthService>()));
    gh.factory<_i14.IProfileRepository>(
        () => _i15.ProfileRepository(gh<_i12.IProfileDataSource>()));
    gh.factory<_i16.IWishlistDatasource>(
        () => _i17.LocalMovieDatasource(gh<_i5.HiveService>())..init());
    gh.factory<_i18.IWishlistRepository>(
        () => _i19.WishlistRepository(gh<_i16.IWishlistDatasource>()));
    gh.factory<_i20.MockMovieRepository>(() => _i20.MockMovieRepository());
    gh.singleton<_i21.ProfileCubit>(
        () => _i21.ProfileCubit(gh<_i14.IProfileRepository>())..init());
    gh.factoryParam<_i22.WishlistCubit, String, dynamic>((
      id,
      _,
    ) =>
        _i22.WishlistCubit(
          id,
          gh<_i18.IWishlistRepository>(),
        )..checkSaved());
    await gh.factoryAsync<_i23.AllMoviesCubit>(
      () {
        final i = _i23.AllMoviesCubit(gh<_i10.IMovieRepository>());
        return i.fetchMovies().then((_) => i);
      },
      preResolve: true,
    );
    gh.factory<_i24.AllWishlistCubit>(() =>
        _i24.AllWishlistCubit(gh<_i18.IWishlistRepository>())..getWishlist());
    gh.singleton<_i25.AuthCubit>(
        () => _i25.AuthCubit(gh<_i6.IAuthRepository>())..init());
    return this;
  }
}
