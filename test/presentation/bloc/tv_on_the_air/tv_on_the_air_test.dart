import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:ditonton/presentation/bloc/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_on_the_air_test.mocks.dart';

@GenerateMocks([GetOnTheAirTV])
void main() {
  late MockGetOnTheAirTV mockGetOnTheAirTV;
  late TvOnTheAirBloc tvOnTheAirBloc;

  setUp(() {
    mockGetOnTheAirTV = MockGetOnTheAirTV();
    tvOnTheAirBloc = TvOnTheAirBloc(mockGetOnTheAirTV);
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

  group('Test tv on the air', () {
    blocTest<TvOnTheAirBloc, TvOnTheAirState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetOnTheAirTV.execute()).thenAnswer((_) async => Right(tTVs));
        return tvOnTheAirBloc;
      },
      act: (TvOnTheAirBloc bloc) => bloc.add(TvOnTheAirRequested()),
      expect: () => [TvOnTheAirLoading(), TvOnTheAirLoaded(tvs: tTVs)],
    );

    blocTest<TvOnTheAirBloc, TvOnTheAirState>(
      'should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetOnTheAirTV.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvOnTheAirBloc;
      },
      act: (TvOnTheAirBloc bloc) => bloc.add(TvOnTheAirRequested()),
      expect: () => [
        TvOnTheAirLoading(),
        TvOnTheAirError(message: 'Server Failure'),
      ],
    );
  });
}
