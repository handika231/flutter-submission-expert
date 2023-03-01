import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../common/state_enum.dart';
import 'about_page.dart';

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
    Future.microtask(
      () => Provider.of<TVListNotifier>(context, listen: false)
        ..fetchTVOnTheAir(),
    );
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
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                // Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
                // TODO: Implement WatchList TV Page
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
              // Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
              // TODO: Implement Search TV Page
            },
          ),
        ],
        title: Text('TV List'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Text(
            'TV On The Air',
            style: kHeading6,
          ),
          Consumer<TVListNotifier>(
            builder: (context, value, child) {
              final state = value.onTheAirState;
              if (state == RequestState.Loading) {
                return Center(
                  child: SpinKitPouringHourGlass(
                    color: Colors.amber,
                    size: 30.0,
                  ),
                );
              } else if (state == RequestState.Loaded) {
                return TVList(value.tvOnTheAir);
              } else {
                return Text('Failed');
              }
            },
          ),
        ],
      ),
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
                //TODO : Implement TV Detail Page
                // Navigator.pushNamed(
                //   context,
                //   MovieDetailPage.ROUTE_NAME,
                //   arguments: movie.id,
                // );
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
