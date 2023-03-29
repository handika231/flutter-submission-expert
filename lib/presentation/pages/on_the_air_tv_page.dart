import 'package:ditonton/presentation/bloc/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../widgets/tv_card_list.dart';

class OnTheAirTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';
  const OnTheAirTVPage({super.key});

  @override
  State<OnTheAirTVPage> createState() => _OnTheAirTVPageState();
}

class _OnTheAirTVPageState extends State<OnTheAirTVPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvOnTheAirBloc>().add(TvOnTheAirRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV On The Air'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
          builder: (context, state) {
            if (state is TvOnTheAirLoading) {
              return Center(
                child: SpinKitWanderingCubes(
                  color: Colors.amber,
                  size: 30.0,
                ),
              );
            }
            if (state is TvOnTheAirLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvs[index];
                  return TVCardList(tv);
                },
                itemCount: state.tvs.length,
              );
            }
            if (state is TvOnTheAirError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            }
            return Center(
              key: Key('error_message'),
              child: Text('Terjadi kesalahan'),
            );
          },
        ),
      ),
    );
  }
}
