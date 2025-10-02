import 'dart:async';

import 'package:dio/dio.dart';

import 'app_exception.dart';

class ErrorMapper {
  AppException map(Object error, {StackTrace? stackTrace}) {
    if (error is AppException) {
      return error;
    }

    if (error is DioException) {
      return _mapDioException(error, stackTrace: stackTrace);
    }

    if (error is TimeoutException) {
      return AppException(
        type: AppExceptionType.timeout,
        message: 'Request timed out',
        error: error,
        stackTrace: stackTrace,
      );
    }

    return AppException(
      type: AppExceptionType.unknown,
      message: error.toString(),
      error: error,
      stackTrace: stackTrace,
    );
  }

  AppException _mapDioException(DioException exception, {StackTrace? stackTrace}) {
    final response = exception.response;
    final statusCode = response?.statusCode;

    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppException(
          type: AppExceptionType.timeout,
          message: 'Network request timed out',
          statusCode: statusCode,
          error: exception,
          stackTrace: stackTrace ?? exception.stackTrace,
        );
      case DioExceptionType.badResponse:
        return AppException(
          type: _typeFromStatus(statusCode),
          message: _messageFromResponse(response) ?? 'Unexpected server response',
          statusCode: statusCode,
          error: exception,
          stackTrace: stackTrace ?? exception.stackTrace,
        );
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        return AppException(
          type: AppExceptionType.network,
          message: 'Unable to reach the server',
          statusCode: statusCode,
          error: exception,
          stackTrace: stackTrace ?? exception.stackTrace,
        );
      case DioExceptionType.cancel:
        return AppException(
          type: AppExceptionType.unknown,
          message: 'Request was cancelled',
          statusCode: statusCode,
          error: exception,
          stackTrace: stackTrace ?? exception.stackTrace,
        );
      case DioExceptionType.unknown:
        return AppException(
          type: AppExceptionType.network,
          message: exception.message ?? 'Network error',
          statusCode: statusCode,
          error: exception,
          stackTrace: stackTrace ?? exception.stackTrace,
        );
    }
  }

  AppExceptionType _typeFromStatus(int? statusCode) {
    if (statusCode == null) {
      return AppExceptionType.unknown;
    }
    if (statusCode >= 200 && statusCode < 300) {
      return AppExceptionType.unknown;
    }
    if (statusCode == 401) {
      return AppExceptionType.unauthorized;
    }
    if (statusCode == 403) {
      return AppExceptionType.forbidden;
    }
    if (statusCode == 404) {
      return AppExceptionType.notFound;
    }
    if (statusCode == 409) {
      return AppExceptionType.conflict;
    }
    if (statusCode == 422) {
      return AppExceptionType.validation;
    }
    if (statusCode >= 500) {
      return AppExceptionType.server;
    }
    return AppExceptionType.network;
  }

  String? _messageFromResponse(Response<dynamic>? response) {
    final data = response?.data;
    if (data is Map<String, dynamic>) {
      final message = data['message'] ?? data['error'];
      if (message is String) {
        return message;
      }
    }
    if (data is String) {
      return data;
    }
    return response?.statusMessage;
  }
}
