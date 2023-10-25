import 'package:education_app_flutter/core/errors/exceptions.dart';
import 'package:education_app_flutter/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late OnBoardingLocalDataSource dataSource;
  late SharedPreferences preferences;

  setUp(() {
    preferences = MockSharedPreferences();
    dataSource = OnBoardingLocalDataSourceImpl(preferences);
  });

  group('cacheFirstTime', () {
    test('should call [SharedPreferences] to cache the data', () async {
      when(() => preferences.setBool(any(), any()))
          .thenAnswer((_) async => false);

      await dataSource.cacheFirstTime();

      verify(() => preferences.setBool('FIRST_TIME', false)).called(1);
      verifyNoMoreInteractions(preferences);
    });

    test(
      'should throw a [CacheException] when there is an error',
      () async {
        when(() => preferences.setBool(any(), any())).thenThrow(
          Exception(),
        );

        final methodCall = dataSource.cacheFirstTime;

        expect(methodCall, throwsA(isA<CacheException>()));
      }
    );
  });

  group('checkIfUserIsFirstTime', () {
    test('should call [SharedPreferences] to get the data', () async {
      when(() => preferences.getBool(any()))
          .thenAnswer((_) => true);

      final result = await dataSource.checkIfUserIsFirstTime();

      expect(result, equals(true));

      verify(() => preferences.getBool('FIRST_TIME')).called(1);
      verifyNoMoreInteractions(preferences);
    });

    test(
        'should throw a [CacheException] when there is an error',
            () async {
          when(() => preferences.getBool(any())).thenThrow(
            Exception(),
          );

          final methodCall = dataSource.checkIfUserIsFirstTime;

          expect(methodCall, throwsA(isA<CacheException>()));
        }
    );
  });
}
