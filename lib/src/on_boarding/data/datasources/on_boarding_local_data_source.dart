abstract class OnBoardingLocalDataSource {
  const OnBoardingLocalDataSource();
  Future<void> cacheFirstTime();
  Future<bool> checkIfUserIsFirstTime();
}
