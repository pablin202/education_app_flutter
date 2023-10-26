import 'package:dartz/dartz.dart';
import 'package:education_app_flutter/src/auth/domain/entities/user.dart';
import 'package:education_app_flutter/src/auth/domain/repos/auth_repo.dart';
import 'package:education_app_flutter/src/auth/domain/usecases/sign_in.dart';
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
    ).thenAnswer((_) async => const Right(fakeUser));

    final result = await usecase(fakeSignUpParams);

    expect(result, equals(const Right<dynamic, LocalUser>(fakeUser)));

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

const fakeUser = LocalUser(
  uid: 'uid',
  email: 'email',
  points: 1,
  fullName: 'fullName',
  groupId: [],
  enrolledCoursesIds: [],
  following: [],
  followers: [],
);

const fakeSignUpParams =
    SignUpParams(email: 'email', password: 'password', fullName: 'fullName');
