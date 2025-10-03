import 'package:dio/dio.dart';

import '../../shared/constants/api_constants.dart';
import '../error/app_exception.dart';

class ApiResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;

    if (data is Map<String, dynamic>) {
      final code = data['code'] as int?;
      final message = data['msg'] as String? ?? data['message'] as String?;

      if (code != null) {
        if (ApiCodeUtils.isSuccess(code)) {
          handler.next(response);
          return;
        }

        if (ApiCodeUtils.isLoginRequired(code)) {
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              type: DioExceptionType.badResponse,
              error: AppException(
                type: AppExceptionType.unauthorized,
                message: message ?? ApiCodeUtils.messageFor(code),
                statusCode: code,
              ),
            ),
          );
          return;
        }

        handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: AppException(
              type: _exceptionTypeFromCode(code),
              message: message ?? ApiCodeUtils.messageFor(code),
              statusCode: code,
            ),
          ),
        );
        return;
      }
    }

    handler.next(response);
  }

  AppExceptionType _exceptionTypeFromCode(int code) {
    if (ApiUserErrorCode.values.contains(code)) {
      if (code == ApiUserErrorCode.noPermission) {
        return AppExceptionType.forbidden;
      }
      if (code == ApiUserErrorCode.paramError ||
          code == ApiUserErrorCode.illegalParam) {
        return AppExceptionType.validation;
      }
      return AppExceptionType.business;
    }

    if (ApiWarningCode.values.contains(code)) {
      return AppExceptionType.validation;
    }

    if (ApiSystemErrorCode.values.contains(code)) {
      return AppExceptionType.server;
    }

    if (ApiUnexpectedErrorCode.values.contains(code)) {
      return AppExceptionType.business;
    }

    return AppExceptionType.unknown;
  }
}
