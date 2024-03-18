import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/hive_movie.dart';

class Movie extends Equatable {
  final String id;
  final String title;
  final String year;
  final List<String> genres;
  final List<num> ratings;
  final String poster;
  final String contentRating;
  final String duration;
  final String releaseDate;
  final num averageRating;
  final String originalTitle;
  final String storyline;
  final List<String> actors;
  final num imdbRating;
  final String posterurl;

  num get avgUsersRating {
    if (ratings.isEmpty) return 0;
    final sum = ratings.fold(
        //Must use num parse because 0 or 0.0 is recognized as int or double
        num.parse('0'),
        (previousValue, element) => previousValue + element);
    return num.parse((sum / ratings.length).toStringAsFixed(1));
  }

  String get formattedDuration {
    //Check if the duration is right format
    if (!duration.startsWith("P")) {
      return "";
    }
    String result = '';

    if (duration.contains('T')) {
      final [date, time] = duration.split('T');
      result += date
          .replaceAll('P', '')
          .replaceAll('Y', 'years ')
          .replaceAll('M', 'months ')
          .replaceAll('D', 'days ');
      result += time
          .replaceAll('H', 'hours ')
          .replaceAll('M', ' minutes ')
          .replaceAll('S', ' seconds ');
    } else {
      result += duration
          .replaceAll('P', '')
          .replaceAll('Y', 'years ')
          .replaceAll('M', ' months ')
          .replaceAll('D', ' days ');
    }
    return result;
  }

  const Movie(
      {required this.id,
      required this.title,
      required this.year,
      required this.genres,
      required this.ratings,
      required this.poster,
      required this.contentRating,
      required this.duration,
      required this.releaseDate,
      required this.averageRating,
      required this.originalTitle,
      required this.storyline,
      required this.actors,
      required this.imdbRating,
      required this.posterurl});

  @override
  List<Object> get props => [id];

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, year: $year, genres: $genres, ratings: $ratings, poster: $poster, contentRating: $contentRating, duration: $duration, releaseDate: $releaseDate, averageRating: $averageRating, originalTitle: $originalTitle, storyline: $storyline, actors: $actors, imdbRating: $imdbRating, posterurl: $posterurl}';
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      year: map['year'] ?? '',
      genres: (map['genres'] as List).cast<String>(),
      ratings: (map['ratings'] as List).cast<num>(),
      poster: map['poster'] ?? '',
      contentRating: map['contentRating'] ?? '',
      duration: map['duration'] ?? '',
      releaseDate: map['releaseDate'] ?? '',
      averageRating: map['averageRating'] as num,
      originalTitle: map['originalTitle'] ?? '',
      storyline: map['storyline'] ?? '',
      actors: (map['actors'] as List).cast<String>(),
      //If imdbRating is string then it means no rating => rating = 0
      imdbRating: (map['imdbRating'] is String) ? 0 : map['imdbRating'] ?? 0,
      posterurl: map['posterurl'] ?? '',
    );
  }

  factory Movie.fromHive(HiveMovie hive) {
    return Movie(
        id: hive.id,
        title: hive.title,
        year: hive.year,
        genres: hive.genres,
        ratings: hive.ratings,
        poster: hive.poster,
        contentRating: hive.contentRating,
        duration: hive.duration,
        releaseDate: hive.releaseDate,
        averageRating: hive.averageRating,
        originalTitle: hive.originalTitle,
        storyline: hive.storyline,
        actors: hive.actors,
        imdbRating: hive.imdbRating,
        posterurl: hive.posterurl);
  }

  HiveMovie toHive() {
    return HiveMovie(
        id,
        title,
        year,
        genres,
        ratings,
        poster,
        contentRating,
        duration,
        releaseDate,
        averageRating,
        originalTitle,
        storyline,
        actors,
        imdbRating,
        posterurl);
  }
}
