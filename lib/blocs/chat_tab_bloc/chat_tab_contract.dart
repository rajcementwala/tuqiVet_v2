// ignore_for_file: constant_identifier_names
import 'package:built_value/built_value.dart';

import '../../core/screen_state.dart';

part 'chat_tab_contract.g.dart';


abstract class ChatTabData implements Built<ChatTabData, ChatTabDataBuilder> {
  factory ChatTabData([void Function(ChatTabDataBuilder) updates]) = _$ChatTabData;

  ChatTabData._();

  ScreenState get state;

  String? get errorMessage;

  bool get hasLocalAuthentication;
}

abstract class ChatTabEvent {}

class InitEvent extends ChatTabEvent {}

class ErrorEvent extends ChatTabEvent {
  ErrorEvent(this.errorMessage);

  final String? errorMessage;
}




