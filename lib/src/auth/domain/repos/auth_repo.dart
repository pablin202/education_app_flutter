import 'package:education_app_flutter/core/enums/update_user.dart';
import 'package:education_app_flutter/core/utils/typedefs.dart';
import 'package:education_app_flutter/src/auth/domain/entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<LocalUser> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultVoid forgotPassword({required String email});

  ResultVoid updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });
}
