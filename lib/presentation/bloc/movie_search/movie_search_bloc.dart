import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies getMovieSearch;
  MovieSearchBloc(this.getMovieSearch) : super(MovieSearchInitial()) {
    on<MovieSearchRequested>((event, emit) async {
      emit(MovieSearchLoading());
      final result = await getMovieSearch.execute(event.query);
      result.fold(
        (failure) {
          emit(MovieSearchError(message: failure.message));
        },
        (movies) {
          emit(MovieSearchLoaded(movies: movies));
        },
      );
    });
  }
}
