import 'package:movie_app/data/datasource/base/i_movie_datasource.dart';
import 'package:movie_app/domain/model/movie.dart';

abstract interface class IWishlistDatasource implements IMovieDatasource {
  Future<bool> addToWishlist(Movie movie);
  Future<bool> removeFromWishlist(String id);
  Future<bool> checkSavedToWishlist(String id);
}