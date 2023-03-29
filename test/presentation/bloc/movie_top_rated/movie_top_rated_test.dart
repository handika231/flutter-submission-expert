import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_top_rated_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockTopRated;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockTopRated = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(mockTopRated);
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

  group('Testing Movie Top Rated', () {
    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should emit [MovieTopRatedLoading, MovieTopRatedLoaded] when data is gotten successfully',
      build: () {
        when(mockTopRated.execute()).thenAnswer((_) async => Right(tMovies));
        return movieTopRatedBloc;
      },
      act: (MovieTopRatedBloc bloc) => bloc.add(MovieTopRatedRequested()),
      expect: () =>
          [MovieTopRatedLoading(), MovieTopRatedLoaded(movies: tMovies)],
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should emit [MovieTopRatedLoading, MovieTopRatedError] when data is gotten unsuccessfully',
      build: () {
        when(mockTopRated.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieTopRatedBloc;
      },
      act: (MovieTopRatedBloc bloc) => bloc.add(MovieTopRatedRequested()),
      expect: () => [
        MovieTopRatedLoading(),
        MovieTopRatedError(message: 'Server Failure'),
      ],
    );
  });
}
