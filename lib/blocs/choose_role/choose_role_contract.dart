// ignore_for_file: constant_identifier_names
import 'package:built_value/built_value.dart';

import '../../core/screen_state.dart';
import '../../core/utils/enum.dart';

part 'choose_role_contract.g.dart';


abstract class ChooseRoleData implements Built<ChooseRoleData, ChooseRoleDataBuilder> {
  factory ChooseRoleData([void Function(ChooseRoleDataBuilder) updates]) = _$ChooseRoleData;

  ChooseRoleData._();

  ScreenState get state;

  String? get errorMessage;
   UserType? get userType;

  bool get hasLocalAuthentication;
}

abstract class ChooseRoleEvent {}

class InitEvent extends ChooseRoleEvent {}
class RedirectToLoginScreenEvent extends ChooseRoleEvent {}
class OnRoleSelectionEvent extends ChooseRoleEvent {
  final UserType userType;

  OnRoleSelectionEvent(this.userType);

}

class ErrorEvent extends ChooseRoleEvent {
  ErrorEvent(this.errorMessage);

  final String? errorMessage;
}




