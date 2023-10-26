import 'dart:convert';

import 'package:education_app_flutter/core/utils/typedefs.dart';
import 'package:education_app_flutter/src/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixture/fixture_reader.dart';

void main() {
  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [LocalUserModel] with the right data', () {
      // Arrange

      // Act
      final result = LocalUserModel.fromMap(tMap);

      // Assert
      expect(result, equals(fakeUserModel));
    });
  });

  group('fromJson', () {
    test('should return a [LocalUserModel] with the right data', () {
      // Arrange

      // Act
      final result = LocalUserModel.fromJson(tJson);

      // Assert
      expect(result, equals(fakeUserModel));
    });
  });

  group('toMap', () {
    test('should return a [Map<String,dynamic>] with the right data', () {
      // Arrange

      // Act
      final result = fakeUserModel.toMap();

      // Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [Json] with the right data', () {
      // Arrange

      // Act
      final result = fakeUserModel.toJson();
      final tJson = jsonEncode({
        "uid": '_empty.uid',
        "email": '_empty.email',
        "points": 0,
        "fullName": '_empty.fullName',
        "groupId": [],
        "enrolledCoursesIds": [],
        "following": [],
        "followers": [],
        "profilePic": '_empty.profilePic',
        "bio": '_empty.bio'
      });
      // Assert
      expect(result, tJson);
    });
  });

  group('copyWith', () {
    test('should return a [LocalUserModel] with different data', () {
      // Arrange

      // Act
      final result = fakeUserModel.copyWith(fullName: 'Paul');
      // Assert
      expect(result.fullName, equals('Paul'));
      expect(result.email, equals(fakeUserModel.email));
    });
  });
}

const fakeUserModel = LocalUserModel(
  uid: '_empty.uid',
  email: '_empty.email',
  points: 0,
  fullName: '_empty.fullName',
  profilePic: '_empty.profilePic',
  bio: '_empty.bio',
);
