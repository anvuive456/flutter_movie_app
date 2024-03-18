import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/dependency_injection/dependency_injection.dart';
import 'package:movie_app/data/repository/impl/mock_movie_repository.dart';

main() async {
  setUpAll(() async {
    await configureDependencies();
  });
  test('Fetch all movies', () async {
    final repo = getIt.get<MockMovieRepository>();
    when(repo.fetchMovies()).thenAnswer((realInvocation) => Future.value([]),);
    verify(repo.fetchMovies()).called(1);

    final data = await repo.fetchMovies();
    expect(data, []);
  });
}
