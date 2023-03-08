import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_detail_response.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final String apiKey = "api_key=${dotenv.env['API_KEY']}";
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();

    dataSource = TVRemoteDataSourceImpl(client: mockHttpClient);
  });
  group('On the Air TV', () {
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv_on_the_air.json')))
        .tvList;

    test('should return list of TV Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_on_the_air.json'), 200));
      // act
      final result = await dataSource.getOnTheAirTV();
      // assert
      expect(result, equals(tTVList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirTV();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated TV', () {
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv_top_rated.json')))
        .tvList;
    test('Should return list of tv when response code is 200', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_top_rated.json'), 200,
                  headers: {
                    'content-type': 'application/json; charset=utf-8',
                  }));
      final result = await dataSource.getTopRatedTV();
      expect(result, equals(tTVList));
    });

    test('Should throw ServerException when response code is other than 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTopRatedTV();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular TV', () {
    final tTVList =
        TVResponse.fromJson(json.decode(readJson('dummy_data/tv_popular.json')))
            .tvList;
    test('Should return list of tv when response code is 200', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_popular.json'), 200,
                  headers: {
                    'content-type': 'application/json; charset=utf-8',
                  }));
      final result = await dataSource.getPopularTV();
      expect(result, equals(tTVList));
    });

    test('Should throw ServerException when response code is other than 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getPopularTV();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated TV', () {
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv_top_rated.json')))
        .tvList;
    test('Should return list of tv when response code is 200', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_top_rated.json'), 200,
                  headers: {
                    'content-type': 'application/json; charset=utf-8',
                  }));
      final result = await dataSource.getTopRatedTV();
      expect(result, equals(tTVList));
    });

    test('Should throw ServerException when response code is other than 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTopRatedTV();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('Get TV Detail', () {
    final tTVId = 88396;
    final tTVDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('Should return list of tv when response code is 200', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tTVId?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_detail.json'), 200,
                  headers: {
                    'content-type': 'application/json; charset=utf-8',
                  }));
      final result = await dataSource.getTVDetail(tTVId);
      expect(result, equals(tTVDetail));
    });

    test('Should throw ServerException when response code is other than 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tTVId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTVDetail(tTVId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
