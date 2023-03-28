// import 'package:ditonton/domain/usecases/search_tv.dart';
// import 'package:flutter/material.dart';

// import '../../common/state_enum.dart';
// import '../../domain/entities/tv.dart';

// class TVSearchNotifier extends ChangeNotifier {
//   final SearchTV searchTV;

//   TVSearchNotifier({required this.searchTV});

//   RequestState state = RequestState.Empty;
//   String message = '';

//   List<TV> searchResult = [];

//   Future<void> fetchTVSearch(String query) async {
//     state = RequestState.Loading;
//     notifyListeners();

//     final result = await searchTV.execute(query);
//     result.fold(
//       (failure) {
//         message = failure.message;
//         state = RequestState.Error;
//         notifyListeners();
//       },
//       (data) {
//         searchResult = data;
//         state = RequestState.Loaded;
//         notifyListeners();
//       },
//     );
//   }
// }
