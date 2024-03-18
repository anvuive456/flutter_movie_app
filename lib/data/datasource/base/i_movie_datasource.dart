import 'package:movie_app/domain/model/movie.dart';

abstract interface class IMovieDatasource {
  Future<List<Movie>> fetchAll();
}
