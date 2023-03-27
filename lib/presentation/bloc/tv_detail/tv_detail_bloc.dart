import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetTVWatchListStatus getTVWatchListStatus;
  TvDetailBloc({
    required this.getTVDetail,
    required this.getTVRecommendations,
    required this.getTVWatchListStatus,
  }) : super(TvDetailInitial()) {
    on<TvDetailRequested>((event, emit) async {
      emit(TvDetailLoading());
      final result = await getTVDetail.execute(event.id);
      final recomendationResult = await getTVRecommendations.execute(event.id);
      final watchListResult = await getTVWatchListStatus.execute(event.id);
      result.fold(
        (failure) async => emit(TvDetailError(message: failure.message)),
        (detail) async => recomendationResult.fold(
            (l) => emit(TvDetailError(message: l.message)),
            (recomendation) => emit(
                  TvDetailLoaded(
                    tvDetail: detail,
                    recomendations: recomendation,
                    isWatchlist: watchListResult,
                  ),
                )),
      );
    });
  }
}
