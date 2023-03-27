part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  final List<Movie> movieRecommendations;
  final bool isAddedToWatchlist;

  MovieDetailLoaded({
    required this.movieDetail,
    required this.movieRecommendations,
    required this.isAddedToWatchlist,
  });

  @override
  List<Object> get props =>
      [movieDetail, movieRecommendations, isAddedToWatchlist];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
