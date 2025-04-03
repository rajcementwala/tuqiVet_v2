// ignore_for_file: constant_identifier_names
import 'package:built_value/built_value.dart';

import '../../core/screen_state.dart';

part 'booking_details_contract.g.dart';


abstract class BookingDetailsScreenData implements Built<BookingDetailsScreenData, BookingDetailsScreenDataBuilder> {
  factory BookingDetailsScreenData([void Function(BookingDetailsScreenDataBuilder) updates]) = _$BookingDetailsScreenData;

  BookingDetailsScreenData._();

  ScreenState get state;

  String? get errorMessage;

  bool get hasLocalAuthentication;
}

abstract class BookingDetailsEvent {}

class InitEvent extends BookingDetailsEvent {}
class NavigateToDoctorDetailScreen extends BookingDetailsEvent {}

class ErrorEvent extends BookingDetailsEvent {
  ErrorEvent(this.errorMessage);

  final String? errorMessage;
}




