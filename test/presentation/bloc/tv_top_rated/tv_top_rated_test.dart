import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:ditonton/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_top_rated_test.mocks.dart';

@GenerateMocks([GetTVOnTopRated])
void main() {
  late TvTopRatedBloc tvTopRatedBloc;
  late MockGetTVOnTopRated mockGetTVOnTopRated;
  setUp(() {
    mockGetTVOnTopRated = MockGetTVOnTopRated();
    tvTopRatedBloc = TvTopRatedBloc(mockGetTVOnTopRated);
  });
  final tTV = TV(
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
  final tTVs = <TV>[tTV];

  group('Test tv top rated', () {
    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTVOnTopRated.execute())
            .thenAnswer((_) async => Right(tTVs));
        return tvTopRatedBloc;
      },
      act: (TvTopRatedBloc bloc) => bloc.add(TVTopRatedRequested()),
      expect: () => [TvTopRatedLoading(), TvTopRatedLoaded(tvs: tTVs)],
    );

    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetTVOnTopRated.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvTopRatedBloc;
      },
      act: (TvTopRatedBloc bloc) => bloc.add(TVTopRatedRequested()),
      expect: () => [
        TvTopRatedLoading(),
        TVTopRatedError(message: 'Server Failure'),
      ],
    );
  });
}
