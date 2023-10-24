import 'package:dartz/dartz.dart';
import 'package:education_app_flutter/core/errors/failures.dart';
import 'package:education_app_flutter/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app_flutter/src/on_boarding/domain/usecases/cache_first_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingRepo extends Mock implements OnBoardingRepo {}

void main() {
  late CacheFirstTime usecase;
  late OnBoardingRepo repository;

  setUp(() {
    repository = MockOnBoardingRepo();
    usecase = CacheFirstTime(repository: repository);
  });

  test('should call the [Repository.cacheFirstTime] and return the right data',
      () async {
    // Arrange
    when(() => repository.cacheFirstTime())
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repository.cacheFirstTime()).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      'should call the [Repository.cacheFirstTime] and return [Failure] if is '
      'unsuccessful', () async {
    // Arrange
    when(() => repository.cacheFirstTime()).thenAnswer((_) async =>
        Left(ServerFailure(statusCode: 500, message: 'Unknown error')));

    // Act
    final result = await usecase();

    // Assert
    expect(
      result,
      equals(Left(ServerFailure(statusCode: 500, message: 'Unknown error'))),
    );
    verify(() => repository.cacheFirstTime()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
