import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([
  GetPopularMovies,
])
void main() {
  late MockGetPopularMovies mockPopular;
  late MoviePopularBloc moviePopularBloc;
  setUp(() {
    mockPopular = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(mockPopular);
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

  group('Test movie popular', () {
    blocTest<MoviePopularBloc, MoviePopularState>(
      'should emit [MoviePopularLoading, MoviePopularLoaded] when data is gotten successfully',
      build: () {
        when(mockPopular.execute()).thenAnswer((_) async => Right(tMovieList));
        return moviePopularBloc;
      },
      act: (MoviePopularBloc bloc) => bloc.add(MoviePopularRequested()),
      expect: () => [
        MoviePopularLoading(),
        MoviePopularLoaded(movies: tMovieList),
      ],
    );

    blocTest<MoviePopularBloc, MoviePopularState>(
      'should emit [MoviePopularLoading, MoviePopularError] when data is gotten unsuccessfully',
      build: () {
        when(mockPopular.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return moviePopularBloc;
      },
      act: (MoviePopularBloc bloc) => bloc.add(MoviePopularRequested()),
      expect: () => [
        MoviePopularLoading(),
        MoviePopularError(message: 'Server Failure'),
      ],
    );
  });
}
