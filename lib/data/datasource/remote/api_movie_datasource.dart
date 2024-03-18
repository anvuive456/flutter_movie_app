import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/network/api_provider.dart';
import 'package:movie_app/data/datasource/base/i_movie_datasource.dart';
import 'package:movie_app/domain/model/movie.dart';

@Injectable(as: IMovieDatasource)
class ApiMovieDatasource implements IMovieDatasource {
  ApiMovieDatasource(this.provider);

  final ApiProvider provider;

  @override
  Future<List<Movie>> fetchAll() async {
    final data = await provider.get(
        'https://raw.githubusercontent.com/FEND16/movie-json-data/master/json/movies-coming-soon.json');
    //The data from githubusercontent is string so must parse to json
    final json = jsonDecode(data);
    final list = (json as List).map((e) => Movie.fromMap(e)).toList();
    return list;
  }
}
