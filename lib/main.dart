import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/presentation/bloc/main_notifier.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_popular/tv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:ditonton/presentation/pages/main_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/constants.dart';
import 'common/utils.dart';
import 'injection.dart' as di;
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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SSLPinning.init();
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
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),

        /* -------------------------------------------------------------------------- */
        /*                                     TV                                     */
        /* -------------------------------------------------------------------------- */

        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvOnTheAirBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistBloc>(),
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
