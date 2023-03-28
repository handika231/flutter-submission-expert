part of 'tv_popular_bloc.dart';

abstract class TvPopularState extends Equatable {
  const TvPopularState();

  @override
  List<Object> get props => [];
}

class TvPopularInitial extends TvPopularState {}

class TvPopularLoading extends TvPopularState {}

class TvPopularLoaded extends TvPopularState {
  final List<TV> tvs;

  const TvPopularLoaded({required this.tvs});

  @override
  List<Object> get props => [tvs];
}

class TVPopularError extends TvPopularState {
  final String message;

  const TVPopularError({required this.message});

  @override
  List<Object> get props => [message];
}
