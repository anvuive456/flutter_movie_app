import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/data/repository/base/i_movie_repository.dart';
import 'package:movie_app/data/repository/impl/movies_repository.dart';

import '../../../domain/model/movie.dart';

part 'all_movies_state.dart';

@injectable
class AllMoviesCubit extends Cubit<AllMoviesState> {
  AllMoviesCubit(this.moviesRepository) : super(const AllMoviesState());

  final IMovieRepository moviesRepository;

  @PostConstruct(preResolve: true)
  Future<void> fetchMovies() async {
    final movies = await moviesRepository.fetchMovies();
    emit(state.copyWith(movies: movies));
  }
}
