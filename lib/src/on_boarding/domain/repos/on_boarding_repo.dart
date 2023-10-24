import 'package:education_app_flutter/core/utils/typedefs.dart';

abstract class OnBoardingRepo {
  const OnBoardingRepo();
  ResultVoid cacheFirstTime();
  ResultFuture<bool> checkIfUserIsFirstTime();
}
