import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_on_the_air_tv.dart';

class TVListNotifier extends ChangeNotifier {
  List<TV> tvOnTheAir = [];

  RequestState onTheAirState = RequestState.Empty;

  String message = '';

  final GetOnTheAirTV getOnTheAirTV;

  TVListNotifier({required this.getOnTheAirTV});

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
