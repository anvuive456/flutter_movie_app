import 'package:injectable/injectable.dart';
import 'package:movie_app/data/datasource/base/i_wishlist_datasource.dart';
import 'package:movie_app/data/repository/base/i_wishlist_repository.dart';
import 'package:movie_app/domain/model/movie.dart';

@Injectable(as: IWishlistRepository)
class WishlistRepository implements IWishlistRepository {
  WishlistRepository(this.datasource);

  final IWishlistDatasource datasource;

  @override
  Future<bool> deleteFromWishList(String id) =>
      datasource.removeFromWishlist(id);

  @override
  Future<List<Movie>> fetchMovies() => datasource.fetchAll();

  @override
  Future<bool> saveToWishlist(Movie movie) => datasource.addToWishlist(movie);

  @override
  Future<bool> checkSavedToWishlist(String id) =>
      datasource.checkSavedToWishlist(id);
}
