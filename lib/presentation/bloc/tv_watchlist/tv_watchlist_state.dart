part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class TvWatchlistInitial extends TvWatchlistState {}

class TVWatchlistLoading extends TvWatchlistState {}

class TVWatchlistError extends TvWatchlistState {
  final String message;

  const TVWatchlistError({required this.message});

  @override
  List<Object> get props => [message];
}

class TVSeriesWatchlistSuccess extends TvWatchlistState {
  final String message;

  const TVSeriesWatchlistSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class TVWatchlistLoaded extends TvWatchlistState {
  final List<TV> tvs;

  const TVWatchlistLoaded({required this.tvs});

  @override
  List<Object> get props => [tvs];
}
