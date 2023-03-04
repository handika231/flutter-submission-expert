import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:flutter/material.dart';

class TVDetailNotifier extends ChangeNotifier {
  final GetTVDetail getTVDetail;

  TVDetailNotifier({required this.getTVDetail});
  late TVDetail tvDetail;
  RequestState tvState = RequestState.Empty;
  List<TVDetail> tvDetailList = [];

  String message = '';

  Future<void> fetchMovieDetail(int id) async {
    tvState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTVDetail.execute(id);
    //TODO: MENAMBAHKAN REKOMENDASI
    detailResult.fold(
      (failure) {
        tvState = RequestState.Error;
        message = failure.message;
        notifyListeners();
      },
      (tv) {
        tvDetail = tv;
        tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
