// ignore_for_file: constant_identifier_names
import 'package:built_value/built_value.dart';

import '../../core/screen_state.dart';


part 'owner_booking_tab_data.g.dart';

abstract class OwnerTabBookingData implements Built<OwnerTabBookingData,OwnerTabBookingDataBuilder> {
  factory OwnerTabBookingData([void Function(OwnerTabBookingDataBuilder) updates]) = _$OwnerTabBookingData;

  OwnerTabBookingData._();

  ScreenState get state;

  String? get errorMessage;


}

abstract class OwnerBookingEvent {}

class InitEvent extends OwnerBookingEvent {

}

class NavigateToBookingDetailsEvent extends OwnerBookingEvent {

}









