import 'package:movie_app/domain/model/movie.dart';

import 'i_movie_repository.dart';

abstract interface class IWishlistRepository implements IMovieRepository {
  Future<bool> saveToWishlist(Movie movie);

  Future<bool> deleteFromWishList(String id);

  Future<bool> checkSavedToWishlist(String id);
}
