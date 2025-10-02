import '../error/app_exception.dart';

sealed class ApiResult<T> {
  const ApiResult();

  R when<R>({
    required R Function(T data) success,
    required R Function(AppException error) failure,
  }) {
    final self = this;
    if (self is ApiSuccess<T>) {
      return success(self.data);
    }
    if (self is ApiFailure<T>) {
      return failure(self.error);
    }
    throw StateError('Unhandled ApiResult variant: $self');
  }

  R maybeWhen<R>({
    R Function(T data)? success,
    R Function(AppException error)? failure,
    required R Function() orElse,
  }) {
    final self = this;
    if (self is ApiSuccess<T>) {
      return success != null ? success(self.data) : orElse();
    }
    if (self is ApiFailure<T>) {
      return failure != null ? failure(self.error) : orElse();
    }
    return orElse();
  }

  bool get isSuccess => this is ApiSuccess<T>;

  bool get isFailure => this is ApiFailure<T>;
}

class ApiSuccess<T> extends ApiResult<T> {
  const ApiSuccess(this.data);

  final T data;
}

class ApiFailure<T> extends ApiResult<T> {
  const ApiFailure(this.error);

  final AppException error;
}
