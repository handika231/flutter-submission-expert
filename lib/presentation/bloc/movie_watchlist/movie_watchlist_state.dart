part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {}

class MovieWatchListLoading extends MovieWatchlistState {}

class MovieWatchListLoaded extends MovieWatchlistState {
  final List<Movie> movies;

  MovieWatchListLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class MovieWatchListError extends MovieWatchlistState {
  final String message;

  MovieWatchListError({required this.message});

  @override
  List<Object> get props => [message];
}

class MovieWatchListSuccess extends MovieWatchlistState {
  final String message;

  MovieWatchListSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
