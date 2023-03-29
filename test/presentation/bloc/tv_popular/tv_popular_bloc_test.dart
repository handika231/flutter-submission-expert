import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:ditonton/presentation/bloc/tv_popular/tv_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTV])
void main() {
  late TvPopularBloc popularBloc;
  late MockGetPopularTV mockGetPopularTV;
  setUp(() {
    mockGetPopularTV = MockGetPopularTV();
    popularBloc = TvPopularBloc(mockGetPopularTV);
  });
  final tTv = TV(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTVs = <TV>[tTv];

  group('Test TV Popular', () {
    blocTest<TvPopularBloc, TvPopularState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTV.execute()).thenAnswer((_) async => Right(tTVs));
        return popularBloc;
      },
      act: (TvPopularBloc bloc) => bloc.add(TVPopularRequested()),
      expect: () => [TvPopularLoading(), TvPopularLoaded(tvs: tTVs)],
    );

    blocTest<TvPopularBloc, TvPopularState>(
      'should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularTV.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularBloc;
      },
      act: (TvPopularBloc bloc) => bloc.add(TVPopularRequested()),
      expect: () => [
        TvPopularLoading(),
        TVPopularError(message: 'Server Failure'),
      ],
    );
  });
}
