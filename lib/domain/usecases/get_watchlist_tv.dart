import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetWatchListTV {
  final TVRepository repository;

  GetWatchListTV(this.repository);

  Future<Either<Failure, List<TV>>> execute() async {
    return repository.getWatchlistTV();
  }
}
