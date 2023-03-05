import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../common/state_enum.dart';
import '../../common/utils.dart';

class WatchListTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';
  const WatchListTVPage({super.key});

  @override
  State<WatchListTVPage> createState() => _WatchListTVPageState();
}

class _WatchListTVPageState extends State<WatchListTVPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTVNotifier>(context, listen: false)
            .fetchWatchlistTV());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistTVNotifier>(context, listen: false).fetchWatchlistTV();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistTVNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: SpinKitWanderingCubes(
                  color: Colors.amber,
                  size: 30.0,
                ),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final tv = data.tvWatchList[index];
                  return TVCardList(tv);
                },
                itemCount: data.tvWatchList.length,
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

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }
}
