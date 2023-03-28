import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTV searchTV;
  TvSearchBloc(this.searchTV) : super(TvSearchInitial()) {
    on<TVSearchRequested>((event, emit) async {
      emit(TvSearchLoading());
      final result = await searchTV.execute(event.query);
      result.fold(
        (failure) => emit(TvSearchError(message: failure.message)),
        (tvs) => emit(TvSearchLoaded(tvs: tvs)),
      );
    });
  }
}
