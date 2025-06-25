import 'package:app_games/core/error/api_exception2.dart';
import 'package:dio/dio.dart';

/// Main class to wrap function for calling HTTP request and also handle the error & exception
abstract class ApiBaseHelper {
  /// Call GET method for HTTP Request
  Future<Response> get(String url, {dynamic data, Options options});

  /// Call POST method for HTTP Request
  Future<Response> post(String url, {dynamic data, Options options});

  /// Call PUT method for HTTP Request
  Future<Response> put(String url, {dynamic data, Options options});

  /// Call DELETE method for HTTP Request
  Future<Response> delete(String url, {dynamic data, Options options});

  /// Call PATCH method for HTTP Request
  Future<Response> patch(String url, {dynamic data, Options options});
}

class ApiBaseHelperImpl implements ApiBaseHelper {
  final Dio dio;

  ApiBaseHelperImpl({required this.dio});

  @override
  Future<Response> get(url, {dynamic data, Options? options}) async {
    // ignore: avoid-late-keyword
    late Response responseJson;
    try {
      responseJson = await dio.get(
        url,
        queryParameters: data,
        options: options,
      );
    } on DioException catch (e) {
      _errorCheck(e);
    }

    return responseJson;
  }

  @override
  Future<Response> post(String url, {dynamic data, Options? options}) async {
    // ignore: avoid-late-keyword
    late Response responseJson;
    try {
      responseJson = await dio.post(
        url,
        data: data,
        options: options,
      );
    } on DioException catch (e) {
      _errorCheck(e);
    }

    return responseJson;
  }

  @override
  Future<Response> put(String url, {dynamic data, Options? options}) async {
    // ignore: avoid-late-keyword
    late Response responseJson;

    try {
      responseJson = await dio.put(
        url,
        data: data,
        options: options,
      );
    } on DioException catch (e) {
      _errorCheck(e);
    }

    return responseJson;
  }

  @override
  Future<Response> delete(String url, {dynamic data, Options? options}) async {
    // ignore: avoid-late-keyword
    late Response responseJson;

    try {
      responseJson = await dio.delete(
        url,
        data: data,
        options: options,
      );
    } on DioException catch (e) {
      _errorCheck(e);
    }

    return responseJson;
  }

  @override
  Future<Response> patch(String url, {dynamic data, Options? options}) async {
    // ignore: avoid-late-keyword
    late Response responseJson;

    try {
      responseJson = await dio.patch(
        url,
        data: data,
        options: options,
      );
    } on DioException catch (e) {
      _errorCheck(e);
    }

    return responseJson;
  }
}

_errorCheck(DioException e) {
  /// Error message for the exception
  String? errorMessage;

  /// Error code for the exception
  String? errorCode;

  /// Error response data
  dynamic errorResponse;

  /// Get message from field message/Message if it exist
  /// Also get error code from field code/Code if it exist
  /// If these fields doesn't exist, will get from default exception error message and code
  if (e.response != null && e.response!.statusCode != null) {
    errorResponse = e.response!.data;

    /// Status Code 400-499 classified as Client Side Error
    /// Otherwise, classified as Server Side Error
    if (e.response!.statusCode! >= 400 && e.response!.statusCode! <= 499) {
      throw ClientErrorException(
        errorMessage,
        errorCode,
        errorResponse,
        e,
      );
    } else {
      throw ServerErrorException(
        errorMessage,
        errorCode,
        errorResponse,
        e,
      );
    }

    /// Other error will classified as Dio
  } else {
    throw e;
  }
}
