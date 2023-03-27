part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class MovieDetailRequested extends MovieDetailEvent {
  final int id;

  const MovieDetailRequested({required this.id});

  @override
  List<Object> get props => [id];
}
