import 'package:dio/dio.dart';

import '../../api/entities/common.dart';
import '../../localizations/base_localization.dart';
import '../error/failures.dart';
import '../logging.dart';
import 'network_info.dart';

enum RequestMethod { get, post, put, delete, head, patch, multiPart }

extension RequestMethodExtension on RequestMethod {
  String get methodName {
    switch (this) {
      case RequestMethod.get:
        return 'GET';

      case RequestMethod.post:
        return 'POST';

      case RequestMethod.put:
        return 'PUT';

      case RequestMethod.delete:
        return 'DELETE';

      case RequestMethod.head:
        return 'HEAD';

      case RequestMethod.patch:
        return 'PATCH';

      case RequestMethod.multiPart:
        return 'POST';
    }
  }
}

enum RequestDataType { body, query, formData }

class RequestData {
  RequestData({required this.data, required this.type});

  RequestDataType type;
  Map<String, dynamic>? data;

  dynamic get getData {
    switch (type) {
      case RequestDataType.formData:
        return FormData.fromMap(data ?? {});

      case RequestDataType.body:
        return data;

      case RequestDataType.query:
        return data;

      default:
        return null;
    }
  }
}

class RestApiClient {RestApiClient(this._dio, this._customErrorHandler, this._networkInfoImpl);

  final Dio _dio;
  final CustomErrorHandler _customErrorHandler;
  final NetworkInfoImpl _networkInfoImpl;

  Future<ResponseEntity<Map<String, dynamic>?>> request({
    required String path,
    required RequestData data,
    required RequestMethod requestMethod,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    if (!await _networkInfoImpl.isConnected) {
      return ResponseEntity(
        null,
        ErrorResult(
          errorMessage:
              BaseLocalization.currentLocalization().noInternetConnection,
          type: ErrorResultType.noInternetConnection,
        ),
      );
    }

    final _options = options ?? Options();
    _options.method = requestMethod.methodName;
    _options.headers = headers;



    final requestOption = _options
        .compose(
          _dio.options,
          path,
          queryParameters: requestMethod==RequestMethod.get?data.getData:{},
          data: data.getData,
          cancelToken: cancelToken,
        )
        .copyWith(baseUrl: _dio.options.baseUrl);
      requestOption.headers.addAll({'Content-Type': 'application/json'});
    try {
      final response = await _dio.fetch(
        requestOption,
      );
      return ResponseEntity(response.data, null);
    } on DioError catch (dioError) {
      log(error: dioError);
      if (dioError.type == DioErrorType.values) {
        return ResponseEntity(dioError.response?.data, null);
      }
      return ResponseEntity(
          null, _customErrorHandler.getErrorMessage(dioError));
    } on Exception catch (error) {
      log(error: error);
      return ResponseEntity(null, _customErrorHandler.getErrorMessage(error));
    }
  }
}
