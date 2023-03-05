import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recomendations.dart';
import 'package:flutter/material.dart';

class TVDetailNotifier extends ChangeNotifier {
  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;

  TVDetailNotifier(
      {required this.getTVDetail, required this.getTVRecommendations});
  late TVDetail tvDetail;
  RequestState tvState = RequestState.Empty;
  List<TVDetail> tvDetailList = [];

  String message = '';

  List<TV> tvRecommendations = [];

  RequestState tvRecommendationState = RequestState.Empty;

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
}
