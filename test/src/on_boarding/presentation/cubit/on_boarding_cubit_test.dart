import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app_flutter/core/errors/failures.dart';
import 'package:education_app_flutter/src/on_boarding/domain/usecases/cache_first_time.dart';
import 'package:education_app_flutter/src/on_boarding/domain/usecases/check_user_first_time.dart';
import 'package:education_app_flutter/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckIfUserIsFirstTime extends Mock
    implements CheckIfUserIsFirstTime {}

class MockCacheFirstTime extends Mock implements CacheFirstTime {}

void main() {
  late CheckIfUserIsFirstTime checkIfUserIsFirstTime;
  late CacheFirstTime cacheFirstTime;
  late OnBoardingCubit cubit;

  setUp(() {
    checkIfUserIsFirstTime = MockCheckIfUserIsFirstTime();
    cacheFirstTime = MockCacheFirstTime();
    cubit = OnBoardingCubit(
      checkIfUserIsFirstTime: checkIfUserIsFirstTime,
      cacheFirstTime: cacheFirstTime,
    );
  });

  tearDown(() => cubit.close());

  test('initial state should be [OnBoardingInitial]', () async {
    expect(cubit.state, const OnBoardingInitial());
  });

  group('checkIfUserIsFirstTime', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckingIfUseIsFirstTime, OnBoardingStatus] '
      'when successful',
      build: () {
        when(() => checkIfUserIsFirstTime())
            .thenAnswer((_) async => const Right(true));
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTime(),
      expect: () => [
        const CheckingIfUseIsFirstTime(),
        const OnBoardingStatus(isFirstTime: true),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTime()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTime);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckingIfUseIsFirstTime, OnBoardingError] when unsuccessful',
      build: () {
        when(() => checkIfUserIsFirstTime())
            .thenAnswer((_) async => Left(fakeFailure));
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTime(),
      expect: () => [
        const CheckingIfUseIsFirstTime(),
        OnBoardingError(message: fakeFailure.toString()),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTime()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTime);
      },
    );
  });

  group('cacheFirstTime', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTime, UserCached] '
          'when successful',
      build: () {
        when(() => cacheFirstTime())
            .thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTime(),
      expect: () => [
        const CachingFirstTime(),
        const UserCached(),
      ],
      verify: (_) {
        verify(() => cacheFirstTime()).called(1);
        verifyNoMoreInteractions(cacheFirstTime);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTime, OnBoardingError] when unsuccessful',
      build: () {
        when(() => cacheFirstTime())
            .thenAnswer((_) async => Left(fakeFailure));
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTime(),
      expect: () => [
        const CachingFirstTime(),
        OnBoardingError(message: fakeFailure.toString()),
      ],
      verify: (_) {
        verify(() => cacheFirstTime()).called(1);
        verifyNoMoreInteractions(cacheFirstTime);
      },
    );
  });
}

final CacheFailure fakeFailure =
    CacheFailure(statusCode: 500, message: 'unknown error');
