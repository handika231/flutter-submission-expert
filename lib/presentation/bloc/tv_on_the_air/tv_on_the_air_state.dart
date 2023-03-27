part of 'tv_on_the_air_bloc.dart';

abstract class TvOnTheAirState extends Equatable {
  const TvOnTheAirState();

  @override
  List<Object> get props => [];
}

class TvOnTheAirInitial extends TvOnTheAirState {}

class TvOnTheAirLoading extends TvOnTheAirState {}

class TvOnTheAirLoaded extends TvOnTheAirState {
  final List<TV> tvs;

  TvOnTheAirLoaded({required this.tvs});

  @override
  List<Object> get props => [tvs];
}

class TvOnTheAirError extends TvOnTheAirState {
  final String message;

  TvOnTheAirError({required this.message});

  @override
  List<Object> get props => [message];
}
