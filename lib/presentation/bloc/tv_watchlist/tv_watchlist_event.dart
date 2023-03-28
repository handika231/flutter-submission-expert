part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();

  @override
  List<Object> get props => [];
}

class TVWatchlistGetRequested extends TvWatchlistEvent {}

class TVWatchlistAddRequested extends TvWatchlistEvent {
  final TVDetail tvDetail;

  const TVWatchlistAddRequested({required this.tvDetail});

  @override
  List<Object> get props => [tvDetail];
}

class TVWatchlistRemoveRequested extends TvWatchlistEvent {
  final TVDetail tvDetail;

  const TVWatchlistRemoveRequested({required this.tvDetail});

  @override
  List<Object> get props => [tvDetail];
}
