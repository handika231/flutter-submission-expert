import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../common/exception.dart';
import '../models/tv_model.dart';
import '../models/tv_response.dart';

abstract class TVRemoteDataSource {
  Future<List<TVModel>> getOnTheAirTV();
}

class TVRemoteDataSourceImpl implements TVRemoteDataSource {
  static final String API_KEY = "api_key=${dotenv.env['API_KEY']}";
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TVRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVModel>> getOnTheAirTV() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));
    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
