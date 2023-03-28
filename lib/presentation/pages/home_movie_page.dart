import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/constants.dart';
import '../../domain/entities/movie.dart';
import 'about_page.dart';
import 'movie_detail_page.dart';
import 'popular_movies_page.dart';
import 'top_rated_movies_page.dart';
import 'watchlist_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();

    context.read<MovieNowPlayingBloc>().add(MovieNowPlayingRequested());
    context.read<MoviePopularBloc>().add(MoviePopularRequested());
    context.read<MovieTopRatedBloc>().add(MovieTopRatedRequested());
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
              title: Text('Trigger Error'),
              onTap: () async => FirebaseCrashlytics.instance.crash(),
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
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
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
          ),
        ],
        title: Text('Movie List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                builder: (context, state) {
                  print('state: $state');
                  if (state is MovieNowPlayingLoading) {
                    return Center(
                      child: SpinKitPouringHourGlass(
                        color: Colors.amber,
                        size: 30.0,
                      ),
                    );
                  }
                  if (state is MovieNowPlayingLoaded) {
                    return MovieList(state.movies);
                  }
                  if (state is MovieNowPlayingError) {
                    return Text(state.message);
                  }

                  return Text('Terjadi kesalahan...');
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<MoviePopularBloc, MoviePopularState>(
                builder: (context, state) {
                  if (state is MoviePopularLoading) {
                    return Center(
                      child: SpinKitPouringHourGlass(
                        color: Colors.amber,
                        size: 30.0,
                      ),
                    );
                  }

                  if (state is MoviePopularLoaded) {
                    return MovieList(state.movies);
                  }
                  if (state is MoviePopularError) {
                    return Text(state.message);
                  }

                  return Text('Terjadi kesalahan...');
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                builder: (context, state) {
                  if (state is MovieTopRatedLoading) {
                    return Center(
                      child: SpinKitPouringHourGlass(
                        color: Colors.amber,
                        size: 30.0,
                      ),
                    );
                  }

                  if (state is MovieTopRatedLoaded) {
                    return MovieList(state.movies);
                  }
                  if (state is MovieTopRatedError) {
                    return Text(state.message);
                  }

                  return Text('Terjadi kesalahan...');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
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

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
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
        itemCount: movies.length,
      ),
    );
  }
}
