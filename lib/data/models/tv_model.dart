import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TVModel extends Equatable {
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

  TVModel(
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

  //from json
  factory TVModel.fromJson(Map<String, dynamic> json) {
    return TVModel(
      backdropPath: json['backdrop_path'],
      firstAirDate: json['first_air_date'],
      genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
      id: json['id'],
      name: json['name'],
      originalLanguage: json['original_language'],
      originalName: json['original_name'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }

  //to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['backdrop_path'] = backdropPath;
    data['first_air_date'] = firstAirDate;
    data['genre_ids'] = List<dynamic>.from(genreIds!.map((x) => x));
    data['id'] = id;
    data['name'] = name;
    data['original_language'] = originalLanguage;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }

  //to entity
  TV toEntity() {
    return TV(
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      genreIds: genreIds,
      id: id,
      name: name,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
