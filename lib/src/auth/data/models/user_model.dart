import 'dart:convert';
import 'package:education_app_flutter/core/utils/typedefs.dart';
import 'package:education_app_flutter/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.groupId,
    super.enrolledCoursesIds,
    super.following,
    super.followers,
    super.profilePic,
    super.bio,
  });

  const LocalUserModel.empty()
      : this(
    uid: '',
    email: '',
    points: 0,
    fullName: '',
  );

  factory LocalUserModel.fromJson(String source) =>
      LocalUserModel.fromMap(jsonDecode(source) as DataMap);

  LocalUserModel.fromMap(DataMap map)
      : this(
          uid: map['uid'] as String,
          email: map['email'] as String,
          points: (map['points'] as num).toInt(),
          fullName: map['fullName'] as String,
          groupId: (map['groupId'] as List<dynamic>).cast<String>(),
          enrolledCoursesIds:
              (map['enrolledCoursesIds'] as List<dynamic>).cast<String>(),
          following: (map['following'] as List<dynamic>).cast<String>(),
          followers: (map['followers'] as List<dynamic>).cast<String>(),
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
        );

  LocalUserModel copyWith({
    String? uid,
    String? email,
    int? points,
    String? fullName,
    List<String>? groupId,
    List<String>? enrolledCoursesIds,
    List<String>? following,
    List<String>? followers,
    String? profilePic,
    String? bio,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      points: points ?? this.points,
      fullName: fullName ?? this.fullName,
      groupId: groupId ?? this.groupId,
      enrolledCoursesIds: enrolledCoursesIds ?? this.enrolledCoursesIds,
      following: following ?? this.following,
      followers: followers ?? this.followers,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
    );
  }

  DataMap toMap() => {
        'uid': uid,
        'email': email,
        'points': points,
        'fullName': fullName,
        'groupId': groupId,
        'enrolledCoursesIds': enrolledCoursesIds,
        'following': following,
        'followers': followers,
        'profilePic': profilePic,
        'bio': bio,
      };

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [uid, email, fullName];
}
