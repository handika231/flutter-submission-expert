import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';

import '../../common/failure.dart';
import '../repositories/tv_repository.dart';

class GetOnTheAirTV {
  final TVRepository repository;

  GetOnTheAirTV(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getOnTheAirTV();
  }
}
