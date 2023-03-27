import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;
  final RemoveWatchlist removeWatchlist;
  final SaveWatchlist saveWatchlist;
  MovieWatchlistBloc({
    required this.getWatchlistMovies,
    required this.removeWatchlist,
    required this.saveWatchlist,
  }) : super(MovieWatchlistInitial()) {
    on<MovieWatchlistRequested>((event, emit) async {
      emit(MovieWatchListLoading());
      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) {
          emit(MovieWatchListError(message: failure.message));
        },
        (movies) {
          emit(MovieWatchListLoaded(movies: movies));
        },
      );
    });

    on<MovieWatchlistRemove>((event, emit) async {
      emit(MovieWatchListLoading());
      final result = await removeWatchlist.execute(event.movieDetail);
      result.fold(
        (failure) {
          emit(MovieWatchListError(message: failure.message));
        },
        (movies) {
          emit(MovieWatchListSuccess(message: movies));
        },
      );
    });
    on<MovieWatchlistAdd>((event, emit) async {
      emit(MovieWatchListLoading());
      final result = await saveWatchlist.execute(event.movieDetail);
      result.fold(
        (failure) {
          emit(MovieWatchListError(message: failure.message));
        },
        (movies) {
          emit(MovieWatchListSuccess(message: movies));
        },
      );
    });
  }
}
