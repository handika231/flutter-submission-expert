import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  MovieDetailBloc(
      {required this.getMovieDetail,
      required this.getMovieRecommendations,
      required this.getWatchListStatus})
      : super(MovieDetailInitial()) {
    on<MovieDetailRequested>((event, emit) async {
      emit(MovieDetailLoading());
      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult =
          await getMovieRecommendations.execute(event.id);
      final isWatchList = await getWatchListStatus.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(MovieDetailError(message: failure.message));
        },
        (movie) {
          recommendationResult.fold(
            (failure) {
              emit(MovieDetailError(message: failure.message));
            },
            (recommendations) {
              emit(
                MovieDetailLoaded(
                  movieDetail: movie,
                  movieRecommendations: recommendations,
                  isAddedToWatchlist: isWatchList,
                ),
              );
            },
          );
        },
      );
    });
  }
}
