import 'package:dartz/dartz.dart';
import 'package:education_app_flutter/src/auth/domain/repos/auth_repo.dart';
import 'package:education_app_flutter/src/auth/domain/usecases/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late AuthRepo repository;
  late SignUp usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = SignUp(repository);
  });

  test('should call [AuthRepo.signUp]', () async {
    when(
      () => repository.signUp(
        email: any(named: 'email'),
        password: any(named: 'password'),
        fullName: any(named: 'fullName'),
      ),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(fakeSignUpParams);

    expect(result, equals(const Right<dynamic, void>(null)));

    verify(
      () => repository.signUp(
        email: fakeSignUpParams.email,
        password: fakeSignUpParams.password,
        fullName: fakeSignUpParams.fullName,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}

const fakeSignUpParams =
    SignUpParams(email: 'email', password: 'password', fullName: 'fullName');
