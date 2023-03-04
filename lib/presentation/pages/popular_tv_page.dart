import 'package:ditonton/presentation/provider/tv_popular_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../common/state_enum.dart';

class PopularTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';
  const PopularTVPage({super.key});

  @override
  State<PopularTVPage> createState() => _PopularTVPageState();
}

class _PopularTVPageState extends State<PopularTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TVPopularNotifier>(context, listen: false)
          .fetchTVPopular(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TVPopularNotifier>(
          builder: (context, data, child) {
            if (data.popularState == RequestState.Loading) {
              return Center(
                child: SpinKitWanderingCubes(
                  color: Colors.amber,
                  size: 30.0,
                ),
              );
            } else if (data.popularState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvPopular[index];
                  return TVCardList(tv);
                },
                itemCount: data.tvPopular.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
