import 'package:flutter/material.dart';

class HomeTVPage extends StatelessWidget {
  static const ROUTE_NAME = '/home-tv-page';
  const HomeTVPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('TV'),
      ),
    );
  }
}
