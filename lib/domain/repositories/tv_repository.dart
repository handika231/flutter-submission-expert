import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getOnTheAirTV();
}
