import '../../common/exception.dart';
import '../models/tv_table.dart';
import 'db/database_helper.dart';

abstract class TVLocalDataSource {
  Future<String> insertWatchlist(TVTable tv);
  Future<String> removeWatchlist(TVTable tv);
  Future<TVTable?> getTVById(int id);
  Future<List<TVTable>> getWatchlistTV();
}

class TVLocalDataSourceImpl implements TVLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TVTable?> getTVById(int id) async {
    final resultt = await databaseHelper.getTVById(id);
    if (resultt != null) {
      return TVTable.fromMap(resultt);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVTable>> getWatchlistTV() async {
    final resultt = await databaseHelper.getWatchlistTV();
    return resultt.map((data) => TVTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(TVTable tv) async {
    try {
      await databaseHelper.insertTVWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TVTable tv) async {
    try {
      await databaseHelper.removeTVWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
