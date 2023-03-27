import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies getMovieNowPlaying;
  MovieNowPlayingBloc(this.getMovieNowPlaying)
      : super(MovieNowPlayingInitial()) {
    on<MovieNowPlayingRequested>((event, emit) async {
      emit(MovieNowPlayingLoading());
      final result = await getMovieNowPlaying.execute();
      result.fold(
        (failure) {
          emit(MovieNowPlayingError(message: failure.message));
        },
        (movies) {
          emit(MovieNowPlayingLoaded(movies: movies));
        },
      );
    });
  }
}
