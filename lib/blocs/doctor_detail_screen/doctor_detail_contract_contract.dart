// ignore_for_file: constant_identifier_names
import 'package:built_value/built_value.dart';

import '../../core/screen_state.dart';

part 'doctor_detail_contract_contract.g.dart';


abstract class DoctorDetailData implements Built<DoctorDetailData,DoctorDetailDataBuilder> {
  factory DoctorDetailData([void Function(DoctorDetailDataBuilder) updates]) = _$DoctorDetailData;

  DoctorDetailData._();

  ScreenState get state;

  String? get errorMessage;

  bool get hasLocalAuthentication;
}

abstract class DoctorDetailEvent {}

class InitEvent extends DoctorDetailEvent {}

class ErrorEvent extends DoctorDetailEvent {
  ErrorEvent(this.errorMessage);

  final String? errorMessage;
}




