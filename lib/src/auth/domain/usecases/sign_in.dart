import 'package:education_app_flutter/core/usecases/usecases.dart';
import 'package:education_app_flutter/core/utils/typedefs.dart';
import 'package:education_app_flutter/src/auth/domain/entities/user.dart';
import 'package:education_app_flutter/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UseCaseWithParams<LocalUser, SignUpParams> {
  const SignUp(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<LocalUser> call(SignUpParams params) => _repo.signUp(
        email: params.email,
        password: params.password,
        fullName: params.fullName,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object?> get props => [email, password, fullName];
}
