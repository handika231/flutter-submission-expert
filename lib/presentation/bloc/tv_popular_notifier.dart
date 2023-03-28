// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/usecases/get_tv_popular.dart';
// import 'package:flutter/material.dart';

// import '../../domain/entities/tv.dart';

// class TVPopularNotifier extends ChangeNotifier {
//   List<TV> tvPopular = [];

//   RequestState popularState = RequestState.Empty;

//   String message = '';

//   final GetPopularTV getPopularTV;

//   TVPopularNotifier({required this.getPopularTV});

//   Future<void> fetchTVPopular() async {
//     popularState = RequestState.Loading;
//     notifyListeners();

//     final result = await getPopularTV.execute();

//     result.fold(
//       (failure) {
//         message = failure.message;
//         popularState = RequestState.Error;
//         notifyListeners();
//       },
//       (tvData) {
//         tvPopular = tvData;
//         popularState = RequestState.Loaded;
//         notifyListeners();
//       },
//     );
//   }
// }
