import 'package:equatable/equatable.dart';

class TV extends Equatable {
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? name;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  num? voteAverage;
  int? voteCount;

  TV(
      {this.backdropPath,
      this.firstAirDate,
      this.genreIds,
      this.id,
      this.name,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.voteAverage,
      this.voteCount});

  TV.watchList({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
