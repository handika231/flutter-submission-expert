import 'package:ditonton/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../widgets/tv_card_list.dart';

class TopRatedTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';
  const TopRatedTVPage({super.key});

  @override
  State<TopRatedTVPage> createState() => _TopRatedTVPageState();
}

class _TopRatedTVPageState extends State<TopRatedTVPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvTopRatedBloc>().add(TVTopRatedRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
          builder: (context, state) {
            if (state is TvTopRatedLoading) {
              return Center(
                child: SpinKitWanderingCubes(
                  color: Colors.amber,
                  size: 30.0,
                ),
              );
            }
            if (state is TvTopRatedLoaded) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final tv = state.tvs[index];
                  return TVCardList(tv);
                },
                itemCount: state.tvs.length,
              );
            }
            if (state is TVTopRatedError) {
              return Center(
                child: Text(state.message),
              );
            }
            return Center(
              key: Key('error_message'),
              child: Text('Something went wrong!'),
            );
          },
        ),
      ),
    );
  }
}
