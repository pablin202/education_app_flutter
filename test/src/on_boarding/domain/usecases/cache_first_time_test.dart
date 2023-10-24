import 'package:dartz/dartz.dart';
import 'package:education_app_flutter/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app_flutter/src/on_boarding/domain/usecases/cache_first_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingRepo extends Mock implements OnBoardingRepo {}

void main() {
  late CacheFirstTime cacheFirstTime;
  late OnBoardingRepo repository;

  setUp(() {
    repository = MockOnBoardingRepo();
    cacheFirstTime = CacheFirstTime(repository: repository);
  });

  test('should call the [Repository.cacheFirstTime]', () async {
    // Arrange
    when(() => repository.cacheFirstTime())
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await cacheFirstTime();

    // Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repository.cacheFirstTime()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
