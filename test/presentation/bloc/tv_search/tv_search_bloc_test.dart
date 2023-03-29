import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTV])
void main() {
  late TvSearchBloc searchBloc;
  late MockSearchTV mockSearchTV;
  setUp(() {
    mockSearchTV = MockSearchTV();
    searchBloc = TvSearchBloc(mockSearchTV);
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
  final tQuery = 'query';

  group('Test tv search bloc', () {
    blocTest<TvSearchBloc, TvSearchState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockSearchTV.execute(tQuery)).thenAnswer((_) async => Right(tTVs));
        return searchBloc;
      },
      act: (TvSearchBloc bloc) => bloc.add(TVSearchRequested(query: tQuery)),
      expect: () => [TvSearchLoading(), TvSearchLoaded(tvs: tTVs)],
    );

    blocTest<TvSearchBloc, TvSearchState>(
      'should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockSearchTV.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (TvSearchBloc bloc) => bloc.add(TVSearchRequested(query: tQuery)),
      expect: () => [
        TvSearchLoading(),
        TvSearchError(message: 'Server Failure'),
      ],
    );
  });
}
