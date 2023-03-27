import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/main_notifier.dart';

class MainPage extends StatelessWidget {
  static const ROUTE_NAME = '/main-page';
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('MainPage build');
    return Scaffold(
      body: BlocBuilder<MainCubit, int>(
        builder: (context, state) => IndexedStack(
          index: state,
          children: context.read<MainCubit>().pages,
        ),
      ),
      bottomNavigationBar: BlocBuilder<MainCubit, int>(
        builder: (context, state) {
          return AnimatedBottomNavigationBar(
            backgroundColor: kOxfordBlue,
            icons: const [
              Icons.movie,
              Icons.tv,
            ],
            activeIndex: state,
            onTap: (index) => context.read<MainCubit>().changePage(index),
            notchSmoothness: NotchSmoothness.smoothEdge,
            activeColor: kMikadoYellow,
            gapLocation: GapLocation.center,
          );
        },
      ),
    );
  }
}
