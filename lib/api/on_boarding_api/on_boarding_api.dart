import '../../core/network/rest_api_client.dart';
import '../api_constants.dart';
import '../api_names.dart';
import '../entities/common.dart';
import '../entities/user.dart';

class OnBoardingApi {
  OnBoardingApi(this._apiClient);

  final RestApiClient _apiClient;

  Future<ResponseEntity<bool>> login(Map<String, dynamic> request) async {
    final response = await _apiClient.request(
        path: Apis.login,

        data: RequestData(data: request, type: RequestDataType.body),
        requestMethod: RequestMethod.post);
    if (response.isSuccess) {
      return const ResponseEntity(true, null);
    }
    return ResponseEntity(false, response.errorResult);
  }

}
