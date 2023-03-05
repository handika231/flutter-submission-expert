import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_tv_watchlist_status.dart';

class TVDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetTVWatchListStatus getWatchListStatus;
  final SaveTVWatchList saveWatchList;
  final RemoveTVWatchList removeWatchList;

  TVDetailNotifier(
      {required this.getTVDetail,
      required this.getTVRecommendations,
      required this.getWatchListStatus,
      required this.saveWatchList,
      required this.removeWatchList});
  late TVDetail tvDetail;
  RequestState tvState = RequestState.Empty;
  List<TVDetail> tvDetailList = [];

  String message = '';

  List<TV> tvRecommendations = [];

  RequestState tvRecommendationState = RequestState.Empty;

  bool isAddedToWatchlist = false;

  Future<void> fetchMovieDetail(int id) async {
    tvState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTVDetail.execute(id);
    final recommendationResult = await getTVRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        tvState = RequestState.Error;
        message = failure.message;
        notifyListeners();
      },
      (tv) {
        tvRecommendationState = RequestState.Loading;
        tvDetail = tv;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            tvRecommendationState = RequestState.Error;
            message = failure.message;
            notifyListeners();
          },
          (tvRecomended) {
            tvRecommendationState = RequestState.Loaded;
            tvRecommendations = tvRecomended;
            notifyListeners();
          },
        );
        tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String watchListMessage = '';

  Future<void> addTVWatchList(TVDetail tv) async {
    final result = await saveWatchList.execute(tv);
    result.fold(
      (failure) {
        watchListMessage = failure.message;
      },
      (message) {
        watchListMessage = message;
      },
    );
    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeTVWatchList(TVDetail tv) async {
    final result = await removeWatchList.execute(tv);
    result.fold(
      (failure) {
        watchListMessage = failure.message;
        notifyListeners();
      },
      (message) {
        watchListMessage = message;
        isAddedToWatchlist = false;
        notifyListeners();
      },
    );
    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    isAddedToWatchlist = result;
    notifyListeners();
  }
}
