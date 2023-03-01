import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../common/exception.dart';
import '../datasources/tv_remote_data_source.dart';

class TVRepositoryImpl implements TVRepository {
  final TVRemoteDataSource remoteDataSource;

  TVRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<TV>>> getOnTheAirTV() async {
    try {
      final result = await remoteDataSource.getOnTheAirTV();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
