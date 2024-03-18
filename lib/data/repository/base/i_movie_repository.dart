import 'package:movie_app/domain/model/movie.dart';

abstract interface class IMovieRepository {
  Future<List<Movie>> fetchMovies();
}