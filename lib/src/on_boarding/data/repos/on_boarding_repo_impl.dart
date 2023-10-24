import 'package:dartz/dartz.dart';
import 'package:education_app_flutter/core/errors/exceptions.dart';
import 'package:education_app_flutter/core/errors/failures.dart';
import 'package:education_app_flutter/core/utils/typedefs.dart';
import 'package:education_app_flutter/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app_flutter/src/on_boarding/domain/repos/on_boarding_repo.dart';

class OnBoardingRepoImpl implements OnBoardingRepo {
  OnBoardingRepoImpl(this._localDataSource);
  final OnBoardingLocalDataSource _localDataSource;

  @override
  ResultVoid cacheFirstTime() async {
    try {
      await _localDataSource.cacheFirstTime();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTime() async {
    try {
      final result = await _localDataSource.checkIfUserIsFirstTime();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }
}
