part of 'on_boarding_cubit.dart';

abstract class OnBoardingState extends Equatable {
  const OnBoardingState();
  @override
  List<Object> get props => [];
}

class OnBoardingInitial extends OnBoardingState {
  const OnBoardingInitial();
}

class CachingFirstTime extends OnBoardingState {
  const CachingFirstTime();
}

class CheckingIfUseIsFirstTime extends OnBoardingState {
  const CheckingIfUseIsFirstTime();
}

class UserCached extends OnBoardingState {
  const UserCached();
}

class OnBoardingStatus extends OnBoardingState {
  const OnBoardingStatus({required this.isFirstTime});

  final bool isFirstTime;
  @override
  List<Object> get props => [isFirstTime];
}

class OnBoardingError extends OnBoardingState {
  const OnBoardingError({required this.message});

  final String message;
  @override
  List<String> get props => [message];
}
