part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class TvDetailRequested extends TvDetailEvent {
  final int id;

  TvDetailRequested({required this.id});

  @override
  List<Object> get props => [id];
}
