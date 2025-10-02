import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/env/app_env_provider.dart';
import '../auth/auth_controller.dart';
import '../error/error_mapper.dart';
import 'api_result.dart';

final dioProvider = Provider<Dio>((ref) {
  final env = ref.watch(appEnvProvider);
  final authState = ref.watch(authControllerProvider).maybeWhen(
        data: (state) => state,
        orElse: () => null,
      );

  final options = BaseOptions(
    baseUrl: env.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 20),
    responseType: ResponseType.json,
  );

  final dio = Dio(options);

  final token = authState?.accessToken;
  if (token != null && token.isNotEmpty) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  if (env.enableNetworkLogs) {
    dio.interceptors.add(LogInterceptor( requestBody: true, responseBody: true));
  }

  return dio;
});

final errorMapperProvider = Provider<ErrorMapper>((ref) => ErrorMapper());

final appHttpClientProvider = Provider<AppHttpClient>((ref) {
  final dio = ref.watch(dioProvider);
  final mapper = ref.watch(errorMapperProvider);
  return AppHttpClient(dio: dio, errorMapper: mapper);
});

class AppHttpClient {
  AppHttpClient({
    required Dio dio,
    required ErrorMapper errorMapper,
  })  : _dio = dio,
        _errorMapper = errorMapper;

  final Dio _dio;
  final ErrorMapper _errorMapper;

  Future<ApiResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(Object? data) decoder,
  }) {
    return _request(
      () => _dio.get<Object?>(path, queryParameters: queryParameters),
      decoder,
    );
  }

  Future<ApiResult<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    required T Function(Object? data) decoder,
  }) {
    return _request(
      () => _dio.post<Object?>(path, data: data, queryParameters: queryParameters),
      decoder,
    );
  }

  Future<ApiResult<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    required T Function(Object? data) decoder,
  }) {
    return _request(
      () => _dio.put<Object?>(path, data: data, queryParameters: queryParameters),
      decoder,
    );
  }

  Future<ApiResult<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    required T Function(Object? data) decoder,
  }) {
    return _request(
      () => _dio.delete<Object?>(path, data: data, queryParameters: queryParameters),
      decoder,
    );
  }

  Future<ApiResult<T>> _request<T>(
    Future<Response<Object?>> Function() send,
    T Function(Object? json) decoder,
  ) async {
    try {
      final response = await send();
      final result = decoder(response.data);
      return ApiSuccess<T>(result);
    } catch (error, stackTrace) {
      final exception = _errorMapper.map(error, stackTrace: stackTrace);
      return ApiFailure<T>(exception);
    }
  }
}
