import 'package:education_app_flutter/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnBoardingLocalDataSource {
  const OnBoardingLocalDataSource();
  Future<void> cacheFirstTime();
  Future<bool> checkIfUserIsFirstTime();
}

class OnBoardingLocalDataSourceImpl extends OnBoardingLocalDataSource {
  const OnBoardingLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> cacheFirstTime() async {
    try {
      await _prefs.setBool('FIRST_TIME', false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTime() async {
    try {
      return _prefs.getBool('FIRST_TIME') ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
