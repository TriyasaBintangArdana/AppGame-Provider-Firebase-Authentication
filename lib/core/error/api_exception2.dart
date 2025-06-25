import 'package:dio/dio.dart';

abstract class ApiException implements Exception {
  final String? message;
  final String? code;
  final String? prefix;
  final dynamic response;
  final DioException? dioError;

  ApiException(
    this.message,
    this.prefix,
    this.code,
    this.response,
    this.dioError,
  );
  @override
  String toString() {
    return "$prefix$message";
  }
}

class ServerErrorException extends ApiException {
  ServerErrorException([
    String? message,
    String? code,
    response,
    DioException? dioError,
  ]) : super(
          message,
          "Server Error: ",
          code,
          response,
          dioError,
        );
}

class ClientErrorException extends ApiException {
  ClientErrorException(
      [String? message, String? code, response, DioException? dioError])
      : super(
          message,
          "Client Error: ",
          code,
          response,
          dioError,
        );
}