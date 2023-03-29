import 'package:ditonton/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    context.read<TvWatchlistBloc>().add(TVWatchlistGetRequested());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<TvWatchlistBloc>().add(TVWatchlistGetRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
          builder: (context, state) {
            if (state is TVWatchlistLoading) {
              return Center(
                child: SpinKitWanderingCubes(
                  color: Colors.amber,
                  size: 30.0,
                ),
              );
            }
            if (state is TVWatchlistLoaded) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final tv = state.tvs[index];
                  return TVCardList(tv);
                },
                itemCount: state.tvs.length,
              );
            }
            if (state is TVWatchlistError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            }
            return Center(
              key: Key('error_message'),
              child: Text('No tv show in watchlist'),
            );
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
