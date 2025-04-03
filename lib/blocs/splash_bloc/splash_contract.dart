// ignore_for_file: constant_identifier_names
import 'package:built_value/built_value.dart';

import '../../core/screen_state.dart';

part 'splash_contract.g.dart';


abstract class SplashData implements Built<SplashData, SplashDataBuilder> {
  factory SplashData([void Function(SplashDataBuilder) updates]) = _$SplashData;

  SplashData._();

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




