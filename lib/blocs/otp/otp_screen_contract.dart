// ignore_for_file: constant_identifier_names
import 'package:built_value/built_value.dart';

import '../../core/screen_state.dart';
import '../../core/utils/enum.dart';

part 'otp_screen_contract.g.dart';


abstract class OtpData implements Built<OtpData, OtpDataBuilder> {
  factory OtpData([void Function(OtpDataBuilder) updates]) = _$OtpData;

  OtpData._();

  ScreenState get state;

  String? get errorMessage;
  UserType? get userType;


  String get countryCode;
  String get phoneNumber;
  bool get isValidOtp;



}

abstract class OtpEvent {}

class InitEvent extends OtpEvent {
  final String code;
  final String phoneNumber;
  final String userType;

  InitEvent(this.code, this.phoneNumber,this.userType);

}



class VerifyOtpEvent extends OtpEvent {
  final String otp;
  VerifyOtpEvent(this.otp);
}

class OTPChangedEvent extends OtpEvent {
  final String otp;
  OTPChangedEvent(this.otp);
}






