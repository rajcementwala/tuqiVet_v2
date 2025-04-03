// ignore_for_file: constant_identifier_names
import 'package:built_value/built_value.dart';

import '../../core/screen_state.dart';

part 'profile_tab_contract.g.dart';


abstract class ProfileTabData implements Built<ProfileTabData, ProfileTabDataBuilder> {
  factory ProfileTabData([void Function(ProfileTabDataBuilder) updates]) = _$ProfileTabData;

  ProfileTabData._();

  ScreenState get state;

  String? get errorMessage;

  bool get hasLocalAuthentication;
}

abstract class SplashEvent {}

class InitEvent extends SplashEvent {}

class ErrorEvent extends SplashEvent {
  ErrorEvent(this.errorMessage);

  final String? errorMessage;
}




