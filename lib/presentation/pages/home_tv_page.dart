import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_popular/tv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/on_the_air_tv_page.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/watch_list_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/constants.dart';
import 'about_page.dart';
import 'popular_tv_page.dart';
import 'top_rated_tv_page.dart';

class HomeTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv-page';
  const HomeTVPage({super.key});

  @override
  State<HomeTVPage> createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvOnTheAirBloc>().add(TvOnTheAirRequested());
    context.read<TvPopularBloc>().add(TVPopularRequested());
    context.read<TvTopRatedBloc>().add(TVTopRatedRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchListTVPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchTVPage.ROUTE_NAME,
              );
            },
          ),
        ],
        title: Text('TV List'),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12),
        children: [
          _buildSubHeading(
            'TV On The Air',
            () {
              Navigator.pushNamed(context, OnTheAirTVPage.ROUTE_NAME);
            },
          ),
          BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
            builder: (context, state) {
              if (state is TvOnTheAirLoading) {
                return Center(
                  child: SpinKitPouringHourGlass(
                    color: Colors.amber,
                    size: 30.0,
                  ),
                );
              }
              if (state is TvOnTheAirLoaded) {
                return TVList(state.tvs);
              }
              if (state is TvOnTheAirError) {
                return Text(state.message);
              }
              return Text('Terjadi Kesalahan...');
            },
          ),
          _buildSubHeading('Popular', () {
            Navigator.pushNamed(context, PopularTVPage.ROUTE_NAME);
          }),
          BlocBuilder<TvPopularBloc, TvPopularState>(
            builder: (context, state) {
              if (state is TvPopularLoading) {
                return Center(
                  child: SpinKitPouringHourGlass(
                    color: Colors.amber,
                    size: 30.0,
                  ),
                );
              }
              if (state is TvPopularLoaded) {
                return TVList(state.tvs);
              }
              if (state is TVPopularError) {
                return Text(state.message);
              }
              return Text('Terjadi Kesalahan...');
            },
          ),
          _buildSubHeading('Top Rated', () {
            Navigator.pushNamed(context, TopRatedTVPage.ROUTE_NAME);
          }),
          BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
            builder: (context, state) {
              if (state is TvTopRatedLoading) {
                return Center(
                  child: SpinKitPouringHourGlass(
                    color: Colors.amber,
                    size: 30.0,
                  ),
                );
              }
              if (state is TvTopRatedLoaded) {
                return TVList(state.tvs);
              }
              if (state is TVTopRatedError) {
                return Text(state.message);
              }
              return Text('Terjadi Kesalahan...');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubHeading(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVList extends StatelessWidget {
  final List<TV> tves;

  TVList(this.tves);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tves[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: SpinKitPouringHourGlass(
                      color: Colors.amber,
                      size: 30.0,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tves.length,
      ),
    );
  }
}
