import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTV getPopularTV;
  TvPopularBloc(this.getPopularTV) : super(TvPopularInitial()) {
    on<TVPopularRequested>((event, emit) async {
      emit(TvPopularLoading());
      final result = await getPopularTV.execute();
      result.fold(
        (failure) => emit(TVPopularError(message: failure.message)),
        (tvs) => emit(TvPopularLoaded(tvs: tvs)),
      );
    });
  }
}
