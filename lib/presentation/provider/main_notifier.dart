import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:flutter/material.dart';

class MainNotifier extends ChangeNotifier {
  int activeIndex = 0;
  List<Widget> pages = [
    HomeMoviePage(),
    HomeTVPage(),
  ];

  void onTap(int index) {
    activeIndex = index;
    notifyListeners();
  }
}
