// import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
// import 'package:flutter/material.dart';

// import '../../common/state_enum.dart';
// import '../../domain/entities/tv.dart';

// class TVOnTheAirNotifier extends ChangeNotifier {
//   final GetOnTheAirTV getOnTheAirTV;
//   TVOnTheAirNotifier(this.getOnTheAirTV);

//   RequestState state = RequestState.Empty;

//   List<TV> tvList = [];

//   String message = '';

//   Future<void> fetchTVOnTheAir() async {
//     state = RequestState.Loading;
//     notifyListeners();

//     final result = await getOnTheAirTV.execute();

//     result.fold(
//       (failure) {
//         message = failure.message;
//         state = RequestState.Error;
//         notifyListeners();
//       },
//       (tvData) {
//         tvList = tvData;
//         state = RequestState.Loaded;
//         notifyListeners();
//       },
//     );
//   }
// }
