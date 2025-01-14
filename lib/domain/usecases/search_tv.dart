import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';

import '../repositories/tv_repository.dart';

class SearchTV {
  final TVRepository repository;
  SearchTV(this.repository);
  Future<Either<Failure, List<TV>>> execute(String query) async {
    return await repository.searchTV(query);
  }
}
