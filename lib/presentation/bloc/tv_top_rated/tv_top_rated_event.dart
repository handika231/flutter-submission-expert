part of 'tv_top_rated_bloc.dart';

abstract class TvTopRatedEvent extends Equatable {
  const TvTopRatedEvent();

  @override
  List<Object> get props => [];
}

class TVTopRatedRequested extends TvTopRatedEvent {}
