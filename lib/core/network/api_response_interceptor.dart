import 'package:dio/dio.dart';

import '../../shared/constants/api_constants.dart';
import '../error/app_exception.dart';

class ApiResponseInterceptor extends Interceptor {
  ApiResponseInterceptor({
    this.onTokenUpdate,
    this.onLoginRequired,
  });

  final void Function(String token)? onTokenUpdate;
  final void Function()? onLoginRequired;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 处理登录接口的 token 保存
    _handleTokenFromResponse(response);

    final data = response.data;

    // 处理 HTTP 400 状态码但有业务 code 的情况
    if (response.statusCode == 400 && data is Map<String, dynamic>) {
      final code = data['code'] as int?;
      if (code != null) {
        _handleBusinessCode(code, data, response, handler);
        return;
      }
    }

    // HTTP 状态码非 200
    if (response.statusCode != 200) {
      handler.next(response);
      return;
    }

    // 检查响应数据格式
    if (data == null) {
      handler.next(response);
      return;
    }

    // 如果有业务状态码，进行判断
    if (data is Map<String, dynamic>) {
      final code = data['code'] as int?;
      if (code != null) {
        _handleBusinessCode(code, data, response, handler);
        return;
      }
    }

    // 兼容旧的判断逻辑，直接通过
    handler.next(response);
  }

  void _handleBusinessCode(
    int code,
    Map<String, dynamic> data,
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final message = data['msg'] as String? ??
                   data['message'] as String? ??
                   ApiCodeUtils.messageFor(code);

    // 成功状态码
    if (ApiCodeUtils.isSuccess(code)) {
      // 标准化响应数据：统一使用 content 字段
      final content = data['content'] ?? data['data'] ?? data;
      response.data = {
        'success': true,
        'code': code,
        'content': content,
        'message': message,
        ...data,
      };
      handler.next(response);
      return;
    }

    // 登录态失效
    if (ApiCodeUtils.isLoginRequired(code)) {
      onLoginRequired?.call();
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: AppException(
            type: AppExceptionType.unauthorized,
            message: message,
            statusCode: code,
          ),
        ),
      );
      return;
    }

    // 其他业务错误
    final shouldShow = ApiCodeUtils.shouldShowError(code);
    handler.reject(
      DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: AppException(
          type: _exceptionTypeFromCode(code),
          message: message,
          statusCode: code,
        ),
      ),
      shouldShow,
    );
  }

  void _handleTokenFromResponse(Response response) {
    final requestUrl = response.requestOptions.path;

    // 只处理登录相关接口
    final loginEndpoints = [
      AuthEndpoints.login.pattern,
      AuthEndpoints.phoneLogin.pattern,
      AuthEndpoints.register.pattern,
    ];

    final shouldHandle = loginEndpoints.any((endpoint) =>
      requestUrl.contains(endpoint)
    );

    if (!shouldHandle) {
      return;
    }

    // 从 header 获取 token
    final headers = response.headers.map;
    final tokenFromHeader = headers['authorization']?.firstOrNull ??
                           headers['Authorization']?.firstOrNull ??
                           headers['token']?.firstOrNull ??
                           headers['Token']?.firstOrNull;

    // 从 data 获取 token
    final data = response.data;
    String? tokenFromPayload;
    if (data is Map<String, dynamic>) {
      final payload = data['content'] ?? data['data'];
      if (payload is Map<String, dynamic>) {
        tokenFromPayload = payload['token'] as String?;
      } else {
        tokenFromPayload = data['token'] as String?;
      }
    }

    final token = tokenFromHeader ?? tokenFromPayload;
    if (token != null && token.isNotEmpty) {
      onTokenUpdate?.call(token);
    }
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
