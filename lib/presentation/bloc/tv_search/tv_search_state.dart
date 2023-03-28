part of 'tv_search_bloc.dart';

abstract class TvSearchState extends Equatable {
  const TvSearchState();

  @override
  List<Object> get props => [];
}

class TvSearchInitial extends TvSearchState {}

class TvSearchLoading extends TvSearchState {}

class TvSearchLoaded extends TvSearchState {
  final List<TV> tvs;

  const TvSearchLoaded({required this.tvs});

  @override
  List<Object> get props => [tvs];
}

class TvSearchError extends TvSearchState {
  final String message;

  const TvSearchError({required this.message});

  @override
  List<Object> get props => [message];
}
