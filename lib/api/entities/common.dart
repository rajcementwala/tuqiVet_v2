import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import '../../core/error/failures.dart';

class Cancellable<T> {
  Cancellable(this.call, this.token);
  final Future<T> call;
  final CancelToken token;
}

class ResponseEntity<T> {
  const ResponseEntity(this.data, this.errorResult);

  factory ResponseEntity.success(T data) => ResponseEntity(data, null);

  factory ResponseEntity.failure(ErrorResult errorResult) =>
      ResponseEntity(null, errorResult);

  final T? data;
  final ErrorResult? errorResult;
}

extension ResponseEntityUtil on ResponseEntity<dynamic> {
  bool get isSuccess => errorResult == null;
}

abstract class ApiResponse<T> {
  int get code;

  T get data;
}

abstract class PaginatedData<T> {
  int get offset;

  int get limit;

  int get total;

  int get count;

  BuiltList<T> get results;
}
