part of 'all_movies_cubit.dart';

final class AllMoviesState extends Equatable {
  final List<Movie> movies;
  final bool loading;
  final Object? error;

  const AllMoviesState({
    this.movies = const [],
    this.loading = true,
    this.error,
  });

  @override
  List<Object?> get props => [movies, loading, error];

  AllMoviesState copyWith({
    List<Movie>? movies,
    bool? loading,
    Object? error,
  }) {
    return AllMoviesState(
      movies: movies ?? this.movies,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}
