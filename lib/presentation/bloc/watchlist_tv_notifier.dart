import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:flutter/material.dart';

class WatchlistTVNotifier extends ChangeNotifier {
  List<TV> tvWatchList = [];

  RequestState state = RequestState.Empty;
  String message = '';

  final GetWatchListTV getWatchListTV;

  WatchlistTVNotifier({required this.getWatchListTV});

  Future<void> fetchWatchlistTV() async {
    state = RequestState.Loading;
    notifyListeners();

    final result = await getWatchListTV.execute();
    result.fold(
      (failure) {
        state = RequestState.Error;
        message = failure.message;
        notifyListeners();
      },
      (tvData) {
        state = RequestState.Loaded;
        tvWatchList = tvData;
        notifyListeners();
      },
    );
  }
}
