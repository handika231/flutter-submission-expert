import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_on_the_air_notifier.dart';
import 'package:ditonton/presentation/provider/tv_popular_notifier.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_top_rated_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/movie_local_data_source.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/datasources/tv_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/repositories/tv_repository.dart';
import 'domain/usecases/get_movie_detail.dart';
import 'domain/usecases/get_movie_recommendations.dart';
import 'domain/usecases/get_now_playing_movies.dart';
import 'domain/usecases/get_popular_movies.dart';
import 'domain/usecases/get_top_rated_movies.dart';
import 'domain/usecases/get_tv_popular.dart';
import 'domain/usecases/get_tv_top_rated.dart';
import 'domain/usecases/get_tv_watchlist_status.dart';
import 'domain/usecases/get_watchlist_movies.dart';
import 'domain/usecases/get_watchlist_status.dart';
import 'domain/usecases/get_watchlist_tv.dart';
import 'domain/usecases/remove_tv_watchlist.dart';
import 'domain/usecases/remove_watchlist.dart';
import 'domain/usecases/save_watchlist.dart';
import 'domain/usecases/search_movies.dart';
import 'presentation/provider/movie_detail_notifier.dart';
import 'presentation/provider/movie_list_notifier.dart';
import 'presentation/provider/movie_search_notifier.dart';
import 'presentation/provider/popular_movies_notifier.dart';
import 'presentation/provider/top_rated_movies_notifier.dart';
import 'presentation/provider/watchlist_movie_notifier.dart';

final locator = GetIt.instance;

void init() {
  /* -------------------------------------------------------------------------- */
  /*                                  provider                                  */
  /* -------------------------------------------------------------------------- */
  locator.registerFactory(
    () => TVOnTheAirNotifier(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TVPopularNotifier(
      getPopularTV: locator(),
    ),
  );
  locator.registerFactory(
    () => TVTopRatedNotifier(
      getTVOnTopRated: locator(),
    ),
  );

  locator.registerFactory(
    () => TVListNotifier(
      getOnTheAirTV: locator(),
      getPopularTV: locator(),
      getTVOnTopRated: locator(),
    ),
  );

  locator.registerFactory(
    () => TVDetailNotifier(
      getTVRecommendations: locator(),
      getTVDetail: locator(),
      getWatchListStatus: locator(),
      removeWatchList: locator(),
      saveWatchList: locator(),
    ),
  );
  locator.registerFactory(
    () => TVSearchNotifier(
      searchTV: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistTVNotifier(
      getWatchListTV: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                                  use case                                  */
  /* -------------------------------------------------------------------------- */

  locator.registerLazySingleton(() => GetOnTheAirTV(locator()));
  locator.registerLazySingleton(() => GetPopularTV(locator()));
  locator.registerLazySingleton(() => GetTVOnTopRated(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => SaveTVWatchList(locator()));
  locator.registerLazySingleton(() => RemoveTVWatchList(locator()));
  locator.registerLazySingleton(() => GetTVWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetWatchListTV(locator()));

  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  /* -------------------------------------------------------------------------- */
  /*                                 repository                                 */
  /* -------------------------------------------------------------------------- */

  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                                data sources                                */
  /* -------------------------------------------------------------------------- */

  locator.registerLazySingleton<TVRemoteDataSource>(
    () => TVRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TVLocalDataSource>(
    () => TVLocalDataSourceImpl(databaseHelper: locator()),
  );

  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );

  /* -------------------------------------------------------------------------- */
  /*                                   helper                                   */
  /* -------------------------------------------------------------------------- */
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  /* -------------------------------------------------------------------------- */
  /*                                  external                                  */
  /* -------------------------------------------------------------------------- */
  locator.registerLazySingleton(() => http.Client());
}
