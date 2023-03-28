part of 'tv_top_rated_bloc.dart';

abstract class TvTopRatedState extends Equatable {
  const TvTopRatedState();

  @override
  List<Object> get props => [];
}

class TvTopRatedInitial extends TvTopRatedState {}

class TvTopRatedLoading extends TvTopRatedState {}

class TvTopRatedLoaded extends TvTopRatedState {
  final List<TV> tvs;

  const TvTopRatedLoaded({required this.tvs});

  @override
  List<Object> get props => [tvs];
}

class TVTopRatedError extends TvTopRatedState {
  final String message;

  const TVTopRatedError({required this.message});

  @override
  List<Object> get props => [message];
}
