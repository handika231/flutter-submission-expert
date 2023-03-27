import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;
  MovieTopRatedBloc(this.getTopRatedMovies) : super(MovieTopRatedInitial()) {
    on<MovieTopRatedRequested>((event, emit) async {
      emit(MovieTopRatedLoading());
      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) {
          emit(MovieTopRatedError(message: failure.message));
        },
        (movies) {
          emit(MovieTopRatedLoaded(movies: movies));
        },
      );
    });
  }
}
