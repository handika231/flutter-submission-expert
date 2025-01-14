part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class MovieSearchRequested extends MovieSearchEvent {
  final String query;

  MovieSearchRequested({required this.query});

  @override
  List<Object> get props => [query];
}
