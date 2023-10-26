import 'package:dartz/dartz.dart';
import 'package:education_app_flutter/src/auth/domain/repos/auth_repo.dart';
import 'package:education_app_flutter/src/auth/domain/usecases/forgot_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late AuthRepo repository;
  late ForgotPassword usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = ForgotPassword(repository);
  });

  test('should call [AuthRepo.forgotPassword]', () async {
    when(
      () => repository.forgotPassword(
        email: any(named: 'email'),
      ),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(fakeEmail);

    expect(result, equals(const Right<dynamic, void>(null)));

    verify(
      () => repository.forgotPassword(
        email: fakeEmail,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}

const fakeEmail = 'email@email.com';
