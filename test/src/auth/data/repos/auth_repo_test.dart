import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:education_app_flutter/core/enums/update_user.dart';
import 'package:education_app_flutter/core/errors/exceptions.dart';
import 'package:education_app_flutter/core/errors/failures.dart';
import 'package:education_app_flutter/src/auth/data/data/auth_remote_data_source.dart';
import 'package:education_app_flutter/src/auth/data/models/user_model.dart';
import 'package:education_app_flutter/src/auth/data/repos/auth_repo_impl.dart';
import 'package:education_app_flutter/src/auth/domain/repos/auth_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteAuthDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepo repository;

  setUp(() {
    remoteDataSource = MockRemoteAuthDataSource();
    repository = AuthRepositoryImpl(remoteDataSource);
    registerFallbackValue(UpdateUserAction.email);
  });

  group('forgotPassword', () {
    test(
        'should call the [RemoteDataSource.forgotPassword] and complete '
        'successfully when the call is successful', () async {
      // Arrange
      when(
        () => remoteDataSource.forgotPassword(
          email: any(named: 'email'),
        ),
      ).thenAnswer((_) async => Future.value());
      // Act
      final result = await repository.forgotPassword(
        email: fakeEmail,
      );
      // Assert
      expect(result, equals(const Right(null)));

      verify(
        () => remoteDataSource.forgotPassword(
          email: fakeEmail,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return a [ServerFailure] when the call is unsuccessful',
        () async {
      // Arrange
      when(
        () => remoteDataSource.forgotPassword(
          email: any(named: 'email'),
        ),
      ).thenThrow(fakeApiException);

      // Act
      final result = await repository.forgotPassword(
        email: fakeEmail,
      );

      // Assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            ServerFailure(
              statusCode: fakeApiException.statusCode,
              message: fakeApiException.message,
            ),
          ),
        ),
      );

      verify(
        () => remoteDataSource.forgotPassword(
          email: fakeEmail,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('signUp', () {
    test(
        'should call the [RemoteDataSource.signUp] and complete '
        'successfully when the call is successful', () async {
      // Arrange
      when(
        () => remoteDataSource.signUp(
          email: any(named: 'email'),
          fullName: any(named: 'fullName'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => Future.value());
      // Act
      final result = await repository.signUp(
        email: fakeEmail,
        fullName: fakeFullName,
        password: fakePassword,
      );
      // Assert
      expect(result, equals(const Right(null)));

      verify(
        () => remoteDataSource.signUp(
          email: fakeEmail,
          fullName: fakeFullName,
          password: fakePassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return a [ServerFailure] when the call is unsuccessful',
        () async {
      // Arrange
      when(
        () => remoteDataSource.signUp(
          email: any(named: 'email'),
          fullName: any(named: 'fullName'),
          password: any(named: 'password'),
        ),
      ).thenThrow(fakeApiException);

      // Act
      final result = await repository.signUp(
        email: fakeEmail,
        fullName: fakeFullName,
        password: fakePassword,
      );

      // Assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            ServerFailure(
              statusCode: fakeApiException.statusCode,
              message: fakeApiException.message,
            ),
          ),
        ),
      );

      verify(
        () => remoteDataSource.signUp(
          email: fakeEmail,
          fullName: fakeFullName,
          password: fakePassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('signIn', () {
    test(
        'should call the [RemoteDataSource.signIn] and complete '
        'successfully when the call is successful', () async {
      // Arrange
      when(
        () => remoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => fakeUserModel);
      // Act
      final result = await repository.signIn(
        email: fakeEmail,
        password: fakePassword,
      );
      // Assert
      expect(result, equals(const Right(fakeUserModel)));

      verify(
        () => remoteDataSource.signIn(
          email: fakeEmail,
          password: fakePassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return a [ServerFailure] when the call is unsuccessful',
        () async {
      // Arrange
      when(
        () => remoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(fakeApiException);

      // Act
      final result = await repository.signIn(
        email: fakeEmail,
        password: fakePassword,
      );

      // Assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            ServerFailure(
              statusCode: fakeApiException.statusCode,
              message: fakeApiException.message,
            ),
          ),
        ),
      );

      verify(
        () => remoteDataSource.signIn(
          email: fakeEmail,
          password: fakePassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('updateUser', () {
    test(
        'should call the [RemoteDataSource.updateUser] and complete '
        'successfully when the call is successful', () async {
      // Arrange
      when(
        () => remoteDataSource.updateUser(
          action: any(named: 'action'),
          userData: any<dynamic>(named: 'userData'),
        ),
      ).thenAnswer((_) async => Future.value());
      // Act
      final result = await repository.updateUser(
        action: UpdateUserAction.email,
        userData: fakeFullName,
      );
      // Assert
      expect(result, equals(const Right(null)));

      verify(
        () => remoteDataSource.updateUser(
          action: UpdateUserAction.email,
          userData: fakeFullName,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return a [ServerFailure] when the call is unsuccessful',
        () async {
      // Arrange
      when(
        () => remoteDataSource.updateUser(
          action: any(named: 'action'),
          userData: any<dynamic>(named: 'userData'),
        ),
      ).thenThrow(fakeApiException);

      // Act
      final result = await repository.updateUser(
        action: UpdateUserAction.email,
        userData: fakeFullName,
      );

      // Assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            ServerFailure(
              statusCode: fakeApiException.statusCode,
              message: fakeApiException.message,
            ),
          ),
        ),
      );

      verify(
        () => remoteDataSource.updateUser(
          action: UpdateUserAction.email,
          userData: fakeFullName,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}

const fakeEmail = 'paul@mail.com';
const fakeFullName = 'Paul Molina';
const fakePassword = '123456';
const fakeUserModel =
    LocalUserModel(uid: 'uid', email: 'email', points: 0, fullName: 'fullName');
const fakeApiException =
    ServerException(statusCode: 500, message: 'Unknown Error Occurred');
