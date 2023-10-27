import 'package:education_app_flutter/core/enums/update_user.dart';
import 'package:education_app_flutter/src/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> forgotPassword({required String email});

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  Future<void> updateUser({required UpdateUserAction action, dynamic userData});
}
