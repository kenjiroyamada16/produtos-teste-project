sealed class ApiResponse<T> {
  const ApiResponse();

  const factory ApiResponse.success(T value) = Success._;
  const factory ApiResponse.failure(Exception error) = Failure._;
}

final class Success<T> extends ApiResponse<T> {
  const Success._(this.value);

  final T value;
}

final class Failure<T> extends ApiResponse<T> {
  const Failure._(this.error);

  final Exception error;
}
