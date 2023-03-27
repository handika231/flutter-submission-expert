import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:flutter/material.dart';

class MainCubit extends Cubit<int> {
  MainCubit() : super(0);

  List<Widget> pages = [
    HomeMoviePage(),
    HomeTVPage(),
  ];
  void changePage(int index) {
    emit(index);
  }
}
