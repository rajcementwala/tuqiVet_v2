// ignore_for_file: constant_identifier_names
import 'package:built_value/built_value.dart';

import '../../core/screen_state.dart';
import '../../core/utils/enum.dart';

part 'user_registration_screen_contract.g.dart';


abstract class UserRegistrationData implements Built<UserRegistrationData, UserRegistrationDataBuilder> {
  factory UserRegistrationData([void Function(UserRegistrationDataBuilder) updates]) = _$UserRegistrationData;

  UserRegistrationData._();

  ScreenState get state;

  String? get errorMessage;
  UserType? get userType;


  String get countryCode;
  String get phoneNumber;
  bool get isValidOtp;
  AddressType? get getAddressType;



}

abstract class OtpEvent {}

class InitEvent extends OtpEvent {

}









