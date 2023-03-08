import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late TVLocalDataSourceImpl dataSource;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TVLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTVWatchlist(testTVTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTVTable);
      // assert
      expect(result, 'Added to Watchlist');
    });
    //database failed
    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTVWatchlist(testTVTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTVTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  //remove watchlist
  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTVWatchlist(testTVTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTVTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });
    //database failed
    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTVWatchlist(testTVTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTVTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  //get tv detail by id
  group('get tv detail by id', () {
    final tID = 1;
    test('should return tv detail when get tv detail from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.getTVById(tID))
          .thenAnswer((_) async => testTVMap);
      // act
      final result = await dataSource.getTVById(tID);
      // assert
      expect(result, testTVTable);
    });

    //should return null when data is not found
    test('should return null when get tv detail from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.getTVById(tID)).thenAnswer((_) async => null);

      // act
      final result = await dataSource.getTVById(tID);
      // assert
      expect(result, null);
    });
  });
}
