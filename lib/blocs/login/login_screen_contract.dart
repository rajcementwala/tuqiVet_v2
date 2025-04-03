// ignore_for_file: constant_identifier_names
import 'package:built_value/built_value.dart';

import '../../core/screen_state.dart';
import '../../core/utils/enum.dart';
import '../../ui/common/countrypicker/countries_info.dart';

part 'login_screen_contract.g.dart';


abstract class LoginData implements Built<LoginData, LoginDataBuilder> {
  factory LoginData([void Function(LoginDataBuilder) updates]) = _$LoginData;

  LoginData._();

  ScreenState get state;

  String? get errorMessage;
  UserType? get userType;

  CountryInfo? get countryInfo;


  bool? get isValidMobileNumber;


}

abstract class LoginEvent {}

class InitEvent extends LoginEvent {
   final CountryInfo? countryInfo;

  InitEvent(this.countryInfo);

}
class SentOtpEvent extends LoginEvent {}
class OnSelectedCountryCodeEvent extends LoginEvent {
  final CountryInfo countryInfo;
  OnSelectedCountryCodeEvent(this.countryInfo);
}

class VerifyMobileNumberEvent extends LoginEvent {
  final String phoneNumber;
  VerifyMobileNumberEvent(this.phoneNumber);
}






