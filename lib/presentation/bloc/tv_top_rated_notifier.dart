import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_tv_top_rated.dart';

class TVTopRatedNotifier extends ChangeNotifier {
  List<TV> tvTopRatedList = [];

  RequestState state = RequestState.Empty;

  String message = '';

  final GetTVOnTopRated getTVOnTopRated;

  TVTopRatedNotifier({required this.getTVOnTopRated});

  Future<void> fetchTVTopRated() async {
    state = RequestState.Loading;
    notifyListeners();

    final result = await getTVOnTopRated.execute();

    result.fold(
      (failure) {
        message = failure.message;
        state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        tvTopRatedList = tvData;
        state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
