import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/main_notifier.dart';

class MainPage extends StatelessWidget {
  static const ROUTE_NAME = '/main-page';
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('MainPage build');
    final provider = Provider.of<MainNotifier>(context, listen: false);
    return Scaffold(
      body: Consumer<MainNotifier>(
        builder: (context, mainNotifier, child) {
          return IndexedStack(
            index: mainNotifier.activeIndex,
            children: provider.pages,
          );
        },
      ),
      bottomNavigationBar: Consumer<MainNotifier>(
        builder: (context, value, child) => AnimatedBottomNavigationBar(
          backgroundColor: kOxfordBlue,
          icons: const [
            Icons.movie,
            Icons.tv,
          ],
          activeIndex: value.activeIndex,
          onTap: (index) => context.read<MainNotifier>().onTap(index),
          notchSmoothness: NotchSmoothness.smoothEdge,
          activeColor: kMikadoYellow,
          gapLocation: GapLocation.center,
        ),
      ),
    );
  }
}
