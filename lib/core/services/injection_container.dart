import 'package:education_app_flutter/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app_flutter/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:education_app_flutter/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app_flutter/src/on_boarding/domain/usecases/cache_first_time.dart';
import 'package:education_app_flutter/src/on_boarding/domain/usecases/check_user_first_time.dart';
import 'package:education_app_flutter/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerFactory(
      () => OnBoardingCubit(
        checkIfUserIsFirstTime: sl(),
        cacheFirstTime: sl(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTime(repository: sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTime(repository: sl()))
    ..registerLazySingleton<OnBoardingRepo>(() => OnBoardingRepoImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton(() => prefs);
}
