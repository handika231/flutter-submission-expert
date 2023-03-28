import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTVOnTopRated getTVOnTopRated;
  TvTopRatedBloc(this.getTVOnTopRated) : super(TvTopRatedInitial()) {
    on<TVTopRatedRequested>((event, emit) async {
      emit(TvTopRatedLoading());
      final result = await getTVOnTopRated.execute();
      result.fold(
        (failure) => emit(TVTopRatedError(message: failure.message)),
        (tvs) => emit(TvTopRatedLoaded(tvs: tvs)),
      );
    });
  }
}
