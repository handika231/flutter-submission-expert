import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockTVRemoteDataSource;
  late MockTVLocalDataSource mockTVLocalDataSource;

  setUp(() {
    mockTVRemoteDataSource = MockTVRemoteDataSource();
    mockTVLocalDataSource = MockTVLocalDataSource();
    repository = TVRepositoryImpl(
      remoteDataSource: mockTVRemoteDataSource,
      localDataSource: mockTVLocalDataSource,
    );
  });

  final tTVModel = TVModel(
    backdropPath: '/backdropPath',
    firstAirDate: '2021-01-01',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTV = TV(
    backdropPath: '/backdropPath',
    firstAirDate: '2021-01-01',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTVModelList = <TVModel>[tTVModel];
  final tTVList = <TV>[tTV];

  group('ON THE AIR TV', () {
    test(
        'Should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getOnTheAirTV())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getOnTheAirTV();
      // assert
      verify(mockTVRemoteDataSource.getOnTheAirTV());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'Should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getOnTheAirTV()).thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirTV();
      // assert
      verify(mockTVRemoteDataSource.getOnTheAirTV());
      expect(result.isLeft(), true);
    });

    test(
        'Should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getOnTheAirTV())
          .thenThrow(SocketException('Failed to connect to the internet'));
      // act
      final result = await repository.getOnTheAirTV();
      // assert
      verify(mockTVRemoteDataSource.getOnTheAirTV());
      expect(result.isLeft(), true);
    });
  });
  group('Popular TV', () {
    test(
        'Should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getPopularTV())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getPopularTV();
      // assert
      verify(mockTVRemoteDataSource.getPopularTV());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'Should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getPopularTV()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTV();
      // assert
      verify(mockTVRemoteDataSource.getPopularTV());
      expect(result.isLeft(), true);
    });

    test(
        'Should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getPopularTV())
          .thenThrow(SocketException('Failed to connect to the internet'));
      // act
      final result = await repository.getPopularTV();
      // assert
      verify(mockTVRemoteDataSource.getPopularTV());
      expect(result.isLeft(), true);
    });
  });
  group('Top Rated TV', () {
    test(
        'Should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTopRatedTV())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getTopRatedTV();
      // assert
      verify(mockTVRemoteDataSource.getTopRatedTV());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'Should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTopRatedTV()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTV();
      // assert
      verify(mockTVRemoteDataSource.getTopRatedTV());
      expect(result.isLeft(), true);
    });

    test(
        'Should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTopRatedTV())
          .thenThrow(SocketException('Failed to connect to the internet'));
      // act
      final result = await repository.getTopRatedTV();
      // assert
      verify(mockTVRemoteDataSource.getTopRatedTV());
      expect(result.isLeft(), true);
    });
  });
}
