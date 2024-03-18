import 'package:hive/hive.dart';

part 'hive_movie.g.dart';

@HiveType(typeId: 0)
class HiveMovie extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String year;
  @HiveField(3)
  List<String> genres;
  @HiveField(4)
  List<num> ratings;
  @HiveField(5)
  String poster;
  @HiveField(6)
  String contentRating;
  @HiveField(7)
  String duration;
  @HiveField(8)
  String releaseDate;
  @HiveField(9)
  num averageRating;
  @HiveField(10)
  String originalTitle;
  @HiveField(11)
  String storyline;
  @HiveField(12)
  List<String> actors;
  @HiveField(13)
  num imdbRating;
  @HiveField(14)
  String posterurl;

  HiveMovie(
      this.id,
      this.title,
      this.year,
      this.genres,
      this.ratings,
      this.poster,
      this.contentRating,
      this.duration,
      this.releaseDate,
      this.averageRating,
      this.originalTitle,
      this.storyline,
      this.actors,
      this.imdbRating,
      this.posterurl);
}
