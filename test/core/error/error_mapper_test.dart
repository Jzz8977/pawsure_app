import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pawsure_app/core/error/app_exception.dart';
import 'package:pawsure_app/core/error/error_mapper.dart';

void main() {
  group('ErrorMapper', () {
    test('maps Dio unauthorized response', () {
      final mapper = ErrorMapper();
      final response = Response<dynamic>(
        requestOptions: RequestOptions(path: '/auth'),
        statusCode: 401,
      );
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/auth'),
        response: response,
        type: DioExceptionType.badResponse,
      );

      final result = mapper.map(dioException);

      expect(result.type, AppExceptionType.unauthorized);
      expect(result.statusCode, 401);
    });

    test('maps timeout exception', () {
      final mapper = ErrorMapper();
      final timeout = TimeoutException('took too long');

      final result = mapper.map(timeout);

      expect(result.type, AppExceptionType.timeout);
    });

    test('maps unknown exception', () {
      final mapper = ErrorMapper();

      final result = mapper.map(Exception('boom'));

      expect(result.type, AppExceptionType.unknown);
      expect(result.message, contains('Exception'));
    });
  });
}
