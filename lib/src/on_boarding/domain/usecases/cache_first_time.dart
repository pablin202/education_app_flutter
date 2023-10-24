import 'package:education_app_flutter/core/usecases/usecases.dart';
import 'package:education_app_flutter/core/utils/typedefs.dart';
import 'package:education_app_flutter/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CacheFirstTime extends UseCaseWithoutParams<void> {
  CacheFirstTime({required this.repository});

  final OnBoardingRepo repository;

  @override
  ResultVoid call() async => repository.cacheFirstTime();
}
