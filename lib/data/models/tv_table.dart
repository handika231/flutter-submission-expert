import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  const TVTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory TVTable.fromEntity(TVDetail json) => TVTable(
        id: json.id,
        title: json.name,
        posterPath: json.posterPath,
        overview: json.overview,
      );

  factory TVTable.fromMap(Map<String, dynamic> map) => TVTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  TV toEntity() => TV.watchList(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: title,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        posterPath,
        overview,
      ];
}
