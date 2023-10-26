import 'package:education_app_flutter/core/usecases/usecases.dart';
import 'package:education_app_flutter/core/utils/typedefs.dart';
import 'package:education_app_flutter/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CheckIfUserIsFirstTime extends UseCaseWithoutParams<bool> {
  CheckIfUserIsFirstTime({required this.repository});

  final OnBoardingRepo repository;

  @override
  ResultFuture<bool> call() async => repository.checkIfUserIsFirstTime();
}
