part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class MovieWatchlistRequested extends MovieWatchlistEvent {}

class MovieWatchlistAdd extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  MovieWatchlistAdd({required this.movieDetail});

  @override
  List<Object> get props => [movieDetail];
}

class MovieWatchlistRemove extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  MovieWatchlistRemove({required this.movieDetail});

  @override
  List<Object> get props => [movieDetail];
}
