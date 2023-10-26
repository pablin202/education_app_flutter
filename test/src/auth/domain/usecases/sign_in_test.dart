import 'package:dartz/dartz.dart';
import 'package:education_app_flutter/src/auth/domain/entities/user.dart';
import 'package:education_app_flutter/src/auth/domain/repos/auth_repo.dart';
import 'package:education_app_flutter/src/auth/domain/usecases/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late AuthRepo repository;
  late SignIn usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = SignIn(repository);
  });

  test('should call [AuthRepo.signIn]', () async {
    when(
      () => repository.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(fakeUser));

    final result = await usecase(fakeSignInParams);

    expect(result, equals(const Right<dynamic, LocalUser>(fakeUser)));

    verify(
      () => repository.signIn(
        email: fakeSignInParams.email,
        password: fakeSignInParams.password,
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

const fakeSignInParams = SignInParams(email: 'email', password: 'password');
