import 'package:bloc/bloc.dart';
import 'package:education_app_flutter/src/on_boarding/domain/usecases/cache_first_time.dart';
import 'package:education_app_flutter/src/on_boarding/domain/usecases/check_user_first_time.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CheckIfUserIsFirstTime checkIfUserIsFirstTime,
    required CacheFirstTime cacheFirstTime,
  })  : _checkIfUserIsFirstTime = checkIfUserIsFirstTime,
        _cacheFirstTime = cacheFirstTime,
        super(const OnBoardingInitial());

  final CheckIfUserIsFirstTime _checkIfUserIsFirstTime;
  final CacheFirstTime _cacheFirstTime;

  Future<void> cacheFirstTime() async {
    emit(const CachingFirstTime());
    final result = await _cacheFirstTime();
    result.fold(
      (failure) => emit(OnBoardingError(message: failure.toString())),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserIsFirstTime() async {
    emit(const CheckingIfUseIsFirstTime());
    final result = await _checkIfUserIsFirstTime();
    result.fold(
      (failure) => emit(OnBoardingError(message: failure.toString())),
      (isFirstTime) => emit(OnBoardingStatus(isFirstTime: isFirstTime)),
    );
  }
}
