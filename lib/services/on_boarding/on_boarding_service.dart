import '../../api/entities/common.dart';
import '../../api/entities/user.dart';
import '../../api/on_boarding_api/on_boarding_api.dart';

class OnBoardingService {
  OnBoardingService(this._onBoardingApi);
  final OnBoardingApi _onBoardingApi;

  Future<ResponseEntity<bool>> login(Map<String,dynamic> request) async {
    return _onBoardingApi.login(request);
  }


}
