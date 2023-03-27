import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_on_the_air_tv.dart';

class TVListNotifier extends ChangeNotifier {
  List<TV> tvOnTheAir = [];

  List<TV> tvPopular = [];

  List<TV> tvTopRated = [];

  RequestState onTheAirState = RequestState.Empty;

  RequestState popularState = RequestState.Empty;

  RequestState topRatedState = RequestState.Empty;

  String message = '';

  final GetOnTheAirTV getOnTheAirTV;

  final GetPopularTV getPopularTV;

  final GetTVOnTopRated getTVOnTopRated;

  TVListNotifier(
      {required this.getOnTheAirTV,
      required this.getPopularTV,
      required this.getTVOnTopRated});

  Future<void> fetchTVPopular() async {
    popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTV.execute();

    result.fold(
      (failure) {
        message = failure.message;
        popularState = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        tvPopular = tvData;
        popularState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTVTopRated() async {
    topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTVOnTopRated.execute();

    result.fold(
      (failure) {
        message = failure.message;
        topRatedState = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        tvTopRated = tvData;
        topRatedState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTVOnTheAir() async {
    onTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTV.execute();

    result.fold(
      (failure) {
        message = failure.message;
        onTheAirState = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        tvOnTheAir = tvData;
        onTheAirState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
