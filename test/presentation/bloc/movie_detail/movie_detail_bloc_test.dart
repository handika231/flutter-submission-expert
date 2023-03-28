import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../movie_detail_notifier_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetMovieRecommendations, GetWatchListStatus])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MovieDetailBloc movieDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
    );
  });
  final tMovieId = 1;
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

  final testMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  group('test movie detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      "Test get detail when success",
      build: () {
        when(
          mockGetMovieDetail.execute(tMovieId),
        ).thenAnswer(
          (_) async => Right(testMovieDetail),
        );

        when(
          mockGetMovieRecommendations.execute(tMovieId),
        ).thenAnswer(
          (_) async => Right(tMovies),
        );

        when(
          mockGetWatchListStatus.execute(tMovieId),
        ).thenAnswer(
          (_) async => true,
        );

        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) =>
          bloc.add(MovieDetailRequested(id: tMovieId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailLoaded(
          movieDetail: testMovieDetail,
          movieRecommendations: tMovies,
          isAddedToWatchlist: true,
        ),
      ],
    );
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Test get detail when Get Movie Detail response is unsuccess',
      build: () {
        when(mockGetMovieDetail.execute(tMovieId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetMovieRecommendations.execute(tMovieId))
            .thenAnswer((_) async => Right(tMovies));
        when(mockGetWatchListStatus.execute(tMovieId))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) =>
          bloc.add(MovieDetailRequested(id: tMovieId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailError(message: 'Server Failure'),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Test get detail when movie recomended response is unsuccess',
      build: () {
        when(mockGetMovieDetail.execute(tMovieId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tMovieId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetWatchListStatus.execute(tMovieId))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) =>
          bloc.add(MovieDetailRequested(id: tMovieId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailError(message: 'Server Failure'),
      ],
    );
  });
}
