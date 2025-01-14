import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVDetail usecase;
  late MockTVRepository mockTVRepository;
  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVDetail(mockTVRepository);
  });

  final tId = 1;

  group('Test Get TV Detail', () {
    test('should get tv detail from the repository', () async {
      // arrange
      when(mockTVRepository.getTVDetail(tId))
          .thenAnswer((_) async => Right(testTVDetail));
      // act
      final result = await usecase.execute(tId);
      // assert
      expect(result, Right(testTVDetail));
    });
  });
}
