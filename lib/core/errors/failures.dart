import 'package:education_app_flutter/core/errors/exceptions.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.statusCode, required this.message});
  final int statusCode;
  final String message;

  @override
  String toString() {
    return '$statusCode Error: $message';
  }

  @override
  List<Object?> get props => [statusCode, message];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.statusCode, required super.message});
  CacheFailure.fromException(CacheException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}

class ServerFailure extends Failure {
  const ServerFailure({required super.statusCode, required super.message});
  ServerFailure.fromException(ServerException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
