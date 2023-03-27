import 'package:ditonton/presentation/bloc/main_notifier.dart';
import 'package:ditonton/presentation/bloc/tv_detail_notifier.dart';
import 'package:ditonton/presentation/bloc/tv_list_notifier.dart';
import 'package:ditonton/presentation/bloc/tv_on_the_air_notifier.dart';
import 'package:ditonton/presentation/bloc/tv_popular_notifier.dart';
import 'package:ditonton/presentation/bloc/tv_search_notifier.dart';
import 'package:ditonton/presentation/bloc/tv_top_rated_notifier.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:ditonton/presentation/pages/main_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'common/constants.dart';
import 'common/utils.dart';
import 'injection.dart' as di;
import 'presentation/bloc/movie_detail_notifier.dart';
import 'presentation/bloc/movie_list_notifier.dart';
import 'presentation/bloc/movie_search_notifier.dart';
import 'presentation/bloc/popular_movies_notifier.dart';
import 'presentation/bloc/top_rated_movies_notifier.dart';
import 'presentation/bloc/watchlist_movie_notifier.dart';
import 'presentation/pages/about_page.dart';
import 'presentation/pages/home_movie_page.dart';
import 'presentation/pages/movie_detail_page.dart';
import 'presentation/pages/on_the_air_tv_page.dart';
import 'presentation/pages/popular_movies_page.dart';
import 'presentation/pages/popular_tv_page.dart';
import 'presentation/pages/search_page.dart';
import 'presentation/pages/search_tv_page.dart';
import 'presentation/pages/top_rated_movies_page.dart';
import 'presentation/pages/watch_list_tv_page.dart';
import 'presentation/pages/watchlist_movies_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  di.init();
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MainCubit(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        /* -------------------------------------------------------------------------- */
        /*                                     TV                                     */
        /* -------------------------------------------------------------------------- */
        ChangeNotifierProvider(
          create: (_) => di.locator<TVListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVPopularNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVOnTheAirNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVTopRatedNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTVNotifier>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(360, 760),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie and TV app',
          theme: ThemeData.dark().copyWith(
            colorScheme: kColorScheme,
            primaryColor: kRichBlack,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: kTextTheme,
          ),
          home: MainPage(),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              /* -------------------------------------------------------------------------- */
              /*                                  TV SERIES                                 */
              /* -------------------------------------------------------------------------- */
              case HomeTVPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => HomeTVPage());
              case PopularTVPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => PopularTVPage());
              case OnTheAirTVPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => OnTheAirTVPage());
              case TopRatedTVPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => TopRatedTVPage());
              case TVDetailPage.ROUTE_NAME:
                final id = settings.arguments as int;
                return CupertinoPageRoute(
                  builder: (_) => TVDetailPage(id: id),
                  settings: settings,
                );
              case SearchTVPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => SearchTVPage());
              case WatchListTVPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => WatchListTVPage());

              /* -------------------------------------------------------------------------- */
              /*                                MOVIE SERIES                                */
              /* -------------------------------------------------------------------------- */
              case '/home':
                return MaterialPageRoute(builder: (_) => HomeMoviePage());
              case PopularMoviesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
              case TopRatedMoviesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
              case MovieDetailPage.ROUTE_NAME:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id),
                  settings: settings,
                );
              case SearchPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => SearchPage());
              case WatchlistMoviesPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
              case AboutPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => AboutPage());
              /* -------------------------------------------------------------------------- */
              /*                                  MAIN PAGE                                 */
              /* -------------------------------------------------------------------------- */
              case MainPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => MainPage());
              default:
                return MaterialPageRoute(
                  builder: (_) {
                    return Scaffold(
                      body: Center(
                        child: Text('Page not found :('),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
