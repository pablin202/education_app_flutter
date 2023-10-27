import 'package:dartz/dartz.dart';
import 'package:education_app_flutter/core/enums/update_user.dart';
import 'package:education_app_flutter/core/errors/exceptions.dart';
import 'package:education_app_flutter/core/errors/failures.dart';
import 'package:education_app_flutter/core/utils/typedefs.dart';
import 'package:education_app_flutter/src/auth/data/data/auth_remote_data_source.dart';
import 'package:education_app_flutter/src/auth/domain/entities/user.dart';
import 'package:education_app_flutter/src/auth/domain/repos/auth_repo.dart';

class AuthRepositoryImpl extends AuthRepo {
  AuthRepositoryImpl(this._dataSource);
  final AuthRemoteDataSource _dataSource;

  @override
  ResultVoid forgotPassword({required String email}) async {
    try {
      await _dataSource.forgotPassword(email: email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    }
  }

  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _dataSource.signIn(email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    }
  }

  @override
  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      await _dataSource.signUp(
        email: email,
        fullName: fullName,
        password: password,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    }
  }

  @override
  ResultVoid updateUser({
    required UpdateUserAction action,
    dynamic userData,
  }) async {
    try {
      await _dataSource.updateUser(action: action, userData: userData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
    }
  }
}
