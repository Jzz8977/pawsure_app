enum AppExceptionType {
  network,
  timeout,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  server,
  validation,
  business,
  unknown,
}

class AppException implements Exception {
  AppException({
    required this.type,
    required this.message,
    this.statusCode,
    this.error,
    this.stackTrace,
  });

  final AppExceptionType type;
  final String message;
  final int? statusCode;
  final Object? error;
  final StackTrace? stackTrace;

  AppException copyWith({
    AppExceptionType? type,
    String? message,
    int? statusCode,
    Object? error,
    StackTrace? stackTrace,
  }) {
    return AppException(
      type: type ?? this.type,
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  String toString() {
    return 'AppException(type: $type, statusCode: $statusCode, message: $message)';
  }
}
