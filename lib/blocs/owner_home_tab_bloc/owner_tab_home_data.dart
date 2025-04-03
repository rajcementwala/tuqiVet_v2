// ignore_for_file: constant_identifier_names
import 'package:built_value/built_value.dart';

import '../../core/screen_state.dart';


part 'owner_tab_home_data.g.dart';

abstract class OwnerTabHomeData implements Built<OwnerTabHomeData,OwnerTabHomeDataBuilder> {
  factory OwnerTabHomeData([void Function(OwnerTabHomeDataBuilder) updates]) = _$OwnerTabHomeData;

  OwnerTabHomeData._();

  ScreenState get state;

  String? get errorMessage;


}

abstract class OwnerHomeEvent {}

class InitEvent extends OwnerHomeEvent {

}

class OnLanguageChangeEvent extends OwnerHomeEvent {
   final String language;

  OnLanguageChangeEvent({required this.language});
}

class RedirectToDoctorListScreen extends OwnerHomeEvent {

}
class ShowAnimalBottomSheetEvent extends OwnerHomeEvent{

}








