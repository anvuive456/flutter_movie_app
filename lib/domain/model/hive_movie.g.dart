// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMovieAdapter extends TypeAdapter<HiveMovie> {
  @override
  final int typeId = 0;

  @override
  HiveMovie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMovie(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      (fields[3] as List).cast<String>(),
      (fields[4] as List).cast<num>(),
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
      fields[9] as num,
      fields[10] as String,
      fields[11] as String,
      (fields[12] as List).cast<String>(),
      fields[13] as num,
      fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveMovie obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.year)
      ..writeByte(3)
      ..write(obj.genres)
      ..writeByte(4)
      ..write(obj.ratings)
      ..writeByte(5)
      ..write(obj.poster)
      ..writeByte(6)
      ..write(obj.contentRating)
      ..writeByte(7)
      ..write(obj.duration)
      ..writeByte(8)
      ..write(obj.releaseDate)
      ..writeByte(9)
      ..write(obj.averageRating)
      ..writeByte(10)
      ..write(obj.originalTitle)
      ..writeByte(11)
      ..write(obj.storyline)
      ..writeByte(12)
      ..write(obj.actors)
      ..writeByte(13)
      ..write(obj.imdbRating)
      ..writeByte(14)
      ..write(obj.posterurl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
