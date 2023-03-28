import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchListTV getWatchListTV;
  final RemoveTVWatchList removeTVWatchList;
  final SaveTVWatchList saveTVWatchList;
  TvWatchlistBloc({
    required this.getWatchListTV,
    required this.removeTVWatchList,
    required this.saveTVWatchList,
  }) : super(TvWatchlistInitial()) {
    on<TVWatchlistGetRequested>((event, emit) async {
      emit(TVWatchlistLoading());
      final result = await getWatchListTV.execute();
      result.fold(
        (failure) => emit(TVWatchlistError(message: failure.message)),
        (tvs) => emit(TVWatchlistLoaded(tvs: tvs)),
      );
    });

    on<TVWatchlistRemoveRequested>((event, emit) async {
      emit(TVWatchlistLoading());
      final result = await removeTVWatchList.execute(event.tvDetail);
      result.fold(
        (failure) => emit(TVWatchlistError(message: failure.message)),
        (message) => emit(TVSeriesWatchlistSuccess(message: message)),
      );
    });

    on<TVWatchlistAddRequested>((event, emit) async {
      emit(TVWatchlistLoading());
      final result = await saveTVWatchList.execute(event.tvDetail);
      result.fold(
        (failure) => emit(TVWatchlistError(message: failure.message)),
        (message) => emit(TVSeriesWatchlistSuccess(message: message)),
      );
    });
  }
}
