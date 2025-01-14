import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTVOnTopRated {
  final TVRepository repository;
  GetTVOnTopRated(this.repository);
  Future<Either<Failure, List<TV>>> execute() {
    return repository.getTopRatedTV();
  }
}
