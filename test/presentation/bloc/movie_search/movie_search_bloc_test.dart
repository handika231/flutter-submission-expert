import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MovieSearchBloc movieSearchBloc;
  late MockSearchMovies mockSearchMovies;
  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(mockSearchMovies);
  });
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];
  final tQuery = 'title';
  //group
  group('testing movie search', () {
    blocTest<MovieSearchBloc, MovieSearchState>(
      'should emit [MovieSearchLoading, MovieSearchLoaded] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovies));
        return movieSearchBloc;
      },
      act: (MovieSearchBloc bloc) =>
          bloc.add(MovieSearchRequested(query: tQuery)),
      expect: () => [
        MovieSearchLoading(),
        MovieSearchLoaded(movies: tMovies),
      ],
    );
    blocTest<MovieSearchBloc, MovieSearchState>(
      'should emit [MovieSearchLoading, MovieSearchError] when data is gotten unsuccessfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieSearchBloc;
      },
      act: (MovieSearchBloc bloc) =>
          bloc.add(MovieSearchRequested(query: tQuery)),
      expect: () => [
        MovieSearchLoading(),
        MovieSearchError(message: 'Server Failure'),
      ],
    );
  });
}
