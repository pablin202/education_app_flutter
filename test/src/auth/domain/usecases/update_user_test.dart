import 'package:dartz/dartz.dart';
import 'package:education_app_flutter/core/enums/update_user.dart';
import 'package:education_app_flutter/src/auth/domain/repos/auth_repo.dart';
import 'package:education_app_flutter/src/auth/domain/usecases/update_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late AuthRepo repository;
  late UpdateUser usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = UpdateUser(repository);
    registerFallbackValue(UpdateUserAction.email);
  });

  test('should call [AuthRepo.updateUser]', () async {
    when(
      () => repository.updateUser(
        action: any(named: 'action'),
        userData: any<dynamic>(named: 'userData'),
      ),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(fakeUpdateUserParams);

    expect(result, equals(const Right<dynamic, void>(null)));

    verify(
      () => repository.updateUser(
        action: fakeUpdateUserParams.action,
        userData: fakeUpdateUserParams.userData,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}

const fakeUpdateUserParams =
    UpdateUserParams(action: UpdateUserAction.email, userData: 'mail@mail.com');
