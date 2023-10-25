import 'package:dartz/dartz.dart';
import 'package:education_app_flutter/core/errors/exceptions.dart';
import 'package:education_app_flutter/core/errors/failures.dart';
import 'package:education_app_flutter/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app_flutter/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:education_app_flutter/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataSource extends Mock implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepo repository;

  setUp(() {
    localDataSource = MockLocalDataSource();
    repository = OnBoardingRepoImpl(localDataSource);
  });

  group('cacheFirstTime', () {
    test(
        'should call the [LocalDataSource.cacheFirstTime] and complete '
        'successfully when the call is successful', () async {
      // Arrange
      when(() => localDataSource.cacheFirstTime())
          .thenAnswer((_) async => Future.value());
      // Act
      final result = await repository.cacheFirstTime();

      // Assert
      expect(result, equals(const Right<Failure, void>(null)));

      verify(() => localDataSource.cacheFirstTime()).called(1);

      verifyNoMoreInteractions(localDataSource);
    });

    test('should return a [CacheFailure] when the call is unsuccessful',
        () async {
      // Arrange
      when(() => localDataSource.cacheFirstTime())
          .thenThrow(fakeCacheException);

      // Act
      final result = await repository.cacheFirstTime();

      // Assert
      expect(
        result,
        equals(
          Left<Failure, void>(
            CacheFailure(
              statusCode: fakeCacheException.statusCode,
              message: fakeCacheException.message,
            ),
          ),
        ),
      );

      verify(() => localDataSource.cacheFirstTime()).called(1);

      verifyNoMoreInteractions(localDataSource);
    });
  });
}

const fakeCacheException =
    CacheException(statusCode: 500, message: 'Unknown Error Occurred');
