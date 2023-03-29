import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_now_playing_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockNowPlaying;
  late MovieNowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    mockNowPlaying = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(mockNowPlaying);
  });

  final tMovies = Movie(
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
  final tMovieList = <Movie>[tMovies];

  group('Test movie now playing', () {
    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'should emit [MovieNowPlayingLoading, MovieNowPlayingLoaded] when data is gotten successfully',
      build: () {
        when(mockNowPlaying.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieNowPlayingBloc;
      },
      act: (MovieNowPlayingBloc bloc) => bloc.add(MovieNowPlayingRequested()),
      expect: () => [
        MovieNowPlayingLoading(),
        MovieNowPlayingLoaded(movies: tMovieList),
      ],
    );

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'should emit [MovieNowPlayingLoading, MovieNowPlayingError] when data is gotten unsuccessfully',
      build: () {
        when(mockNowPlaying.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieNowPlayingBloc;
      },
      act: (MovieNowPlayingBloc bloc) => bloc.add(MovieNowPlayingRequested()),
      expect: () => [
        MovieNowPlayingLoading(),
        MovieNowPlayingError(message: 'Server Failure'),
      ],
    );
  });
}
