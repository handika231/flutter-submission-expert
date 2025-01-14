import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class RemoveTVWatchList {
  final TVRepository repository;
  RemoveTVWatchList(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) async {
    return repository.removeWatchlist(tv);
  }
}
