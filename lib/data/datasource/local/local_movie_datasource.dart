import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/db/hive_service.dart';
import 'package:movie_app/data/datasource/base/i_movie_datasource.dart';
import 'package:movie_app/data/datasource/base/i_wishlist_datasource.dart';
import 'package:movie_app/domain/model/hive_movie.dart';
import 'package:movie_app/domain/model/movie.dart';

@Injectable(as: IWishlistDatasource)
class LocalMovieDatasource implements IWishlistDatasource {
  LocalMovieDatasource(this.service);

  final HiveService service;

  @PostConstruct()
  init() {
    service.registerAdapter(HiveMovieAdapter());
  }

  @override
  Future<List<Movie>> fetchAll() async {
    final data = await service.findMany<HiveMovie>();
    return data.map((e) => Movie.fromHive(e)).toList();
  }

  ///Add movie to wish list
  ///
  /// return true if added
  ///
  /// otherwise return false
  @override
  Future<bool> addToWishlist(Movie movie) async {
    try {
      await service.insert<HiveMovie>(movie.id, movie.toHive());
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  @override
  Future<bool> removeFromWishlist(String id) async {
    try {
      await service.delete<HiveMovie>(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> checkSavedToWishlist(String id) async {
    try {
      final movie = await service.findUnique<HiveMovie>(id);
      return !(movie == null);
    } catch (e) {
      return false;
    }
  }
}
