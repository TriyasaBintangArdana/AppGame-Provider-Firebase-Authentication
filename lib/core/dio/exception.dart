import 'package:app_games/core/error/api_exception2.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final ApiException? apiException;

  @override
  List<Object> get props => [];

  const Failure({this.apiException});
}

/// Failure for server side error
class ServerFailure extends Failure {
  const ServerFailure({ApiException? apiException})
      : super(apiException: apiException);
}

/// Failure for client side error
class ClientFailure extends Failure {
  const ClientFailure({ApiException? apiException})
      : super(apiException: apiException);
}