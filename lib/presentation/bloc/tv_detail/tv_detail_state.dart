part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailLoaded extends TvDetailState {
  final TVDetail tvDetail;
  final List<TV> recomendations;
  final bool isWatchlist;

  TvDetailLoaded(
      {required this.tvDetail,
      required this.recomendations,
      required this.isWatchlist});

  @override
  List<Object> get props => [tvDetail, recomendations, isWatchlist];
}

class TvDetailError extends TvDetailState {
  final String message;

  TvDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
