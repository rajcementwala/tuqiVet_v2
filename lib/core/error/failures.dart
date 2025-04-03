import 'package:dio/dio.dart';
import 'package:sprintf/sprintf.dart';
import '../../localizations/base_localization.dart';

enum ErrorResultType {
  connectTimeout,
  sendTimeout,
  receiveTimeout,
  cancel,
  response,
  noInternetConnection,
  other
}

class ErrorResult {
  String errorMessage;
  ErrorResultType type;
  ErrorResult({required this.errorMessage, required this.type});
}

class CustomErrorHandler {
  const CustomErrorHandler();

  ErrorResult getErrorMessage(dynamic exception) {
    if (exception is DioError) {
      switch (exception.type) {
        case DioErrorType.cancel:
          return ErrorResult(
              errorMessage:
                  BaseLocalization.currentLocalization().cancelApiRequestError,
              type: ErrorResultType.cancel);

        case DioErrorType.connectionTimeout:
          return ErrorResult(
              errorMessage: BaseLocalization.currentLocalization()
                  .connectionTimeoutApiRequestError,
              type: ErrorResultType.connectTimeout);

        case DioErrorType.unknown:
          return ErrorResult(
              errorMessage:
                  BaseLocalization.currentLocalization().noInternetConnection,
              type: ErrorResultType.noInternetConnection);

        case DioErrorType.receiveTimeout:
          return ErrorResult(
              errorMessage: BaseLocalization.currentLocalization()
                  .receiveTimeoutApiRequestError,
              type: ErrorResultType.receiveTimeout);
        case DioErrorType.values:
          return ErrorResult(
              errorMessage: sprintf(
                  BaseLocalization.currentLocalization()
                      .invalidStatusApiRequestError,
                  [exception.response!.statusCode]),
              type: ErrorResultType.response);
        case DioErrorType.sendTimeout:
          return ErrorResult(
              errorMessage: BaseLocalization.currentLocalization()
                  .connectionTimeoutApiRequestError,
              type: ErrorResultType.sendTimeout);
        case DioExceptionType.badCertificate:
          return ErrorResult(
              errorMessage: BaseLocalization.currentLocalization()
                  .receiveTimeoutApiRequestError,
              type: ErrorResultType.receiveTimeout);
        case DioExceptionType.badResponse:
          return ErrorResult(
              errorMessage: BaseLocalization.currentLocalization()
                  .receiveTimeoutApiRequestError,
              type: ErrorResultType.receiveTimeout);

        case DioExceptionType.connectionError:
          return ErrorResult(
              errorMessage: BaseLocalization.currentLocalization()
                  .commonApiError,
              type: ErrorResultType.receiveTimeout);
      }
    } else {
      return ErrorResult(
          errorMessage: exception.toString(), type: ErrorResultType.other);
    }
  }
}
