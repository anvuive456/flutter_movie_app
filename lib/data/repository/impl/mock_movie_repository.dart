import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/data/datasource/base/i_movie_datasource.dart';
import 'package:movie_app/data/repository/base/i_movie_repository.dart';
import 'package:movie_app/domain/model/movie.dart';

@visibleForTesting
@injectable
class MockMovieRepository extends Mock implements IMovieRepository {}
