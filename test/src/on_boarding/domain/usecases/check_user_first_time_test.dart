import 'package:dartz/dartz.dart';
import 'package:education_app_flutter/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app_flutter/src/on_boarding/domain/usecases/check_user_first_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingRepo extends Mock implements OnBoardingRepo {}

void main() {
  late CheckIsUserIfFirstTime usecase;
  late OnBoardingRepo repository;

  setUp(() {
    repository = MockOnBoardingRepo();
    usecase = CheckIsUserIfFirstTime(repository: repository);
  });

  test('should call the [Repository.checkIfUserIsFirstTime]', () async {
    // Arrange
    when(() => repository.checkIfUserIsFirstTime())
        .thenAnswer((_) async => const Right(true));

    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(const Right<dynamic, void>(true)));
    verify(() => repository.checkIfUserIsFirstTime()).called(1);
    verifyNoMoreInteractions(repository);
  });
}