import 'package:flutter_test/flutter_test.dart';
import 'package:pawsure_app/core/error/app_exception.dart';
import 'package:pawsure_app/core/network/api_result.dart';

void main() {
  test('when returns success data', () {
    const result = ApiSuccess<int>(42);

    final output = result.when(
      success: (data) => data * 2,
      failure: (_) => 0,
    );

    expect(result.isSuccess, isTrue);
    expect(result.isFailure, isFalse);
    expect(output, 84);
  });

  test('maybeWhen handles failure branch', () {
    final exception = AppException(
      type: AppExceptionType.network,
      message: 'Network error',
    );
    final result = ApiFailure<int>(exception);

    final value = result.maybeWhen(
      success: (data) => data,
      orElse: () => -1,
    );

    expect(value, -1);
    expect(result.isFailure, isTrue);
    expect(
      result.when(
        success: (_) => 0,
        failure: (error) => error.message,
      ),
      'Network error',
    );
  });
}
