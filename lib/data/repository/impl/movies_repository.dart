import 'package:injectable/injectable.dart';
import 'package:movie_app/data/datasource/base/i_movie_datasource.dart';
import 'package:movie_app/data/repository/base/i_movie_repository.dart';
import 'package:movie_app/domain/model/movie.dart';

@Injectable(as: IMovieRepository)
class MoviesRepository implements IMovieRepository {
  MoviesRepository(this.datasource);

  final IMovieDatasource datasource;

  @override
  Future<List<Movie>> fetchMovies() => datasource.fetchAll();
}
