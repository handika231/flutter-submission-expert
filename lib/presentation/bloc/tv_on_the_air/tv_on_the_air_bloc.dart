import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_on_the_air_event.dart';
part 'tv_on_the_air_state.dart';

class TvOnTheAirBloc extends Bloc<TvOnTheAirEvent, TvOnTheAirState> {
  final GetOnTheAirTV getOnTheAirTV;
  TvOnTheAirBloc(this.getOnTheAirTV) : super(TvOnTheAirInitial()) {
    on<TvOnTheAirRequested>((event, emit) async {
      emit(TvOnTheAirLoading());
      final result = await getOnTheAirTV.execute();
      result.fold(
        (failure) {
          emit(TvOnTheAirError(message: failure.message));
        },
        (tv) {
          emit(TvOnTheAirLoaded(tvs: tv));
        },
      );
    });
  }
}
