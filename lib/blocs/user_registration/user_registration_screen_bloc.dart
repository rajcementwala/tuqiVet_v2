import 'dart:async';
import '../../core/base_bloc.dart';
import '../../core/cache/preference_store.dart';
import '../../core/event_bus.dart';
import '../../core/screen_state.dart';
import 'user_registration_screen_contract.dart';

class UserRegistrationBloc extends BaseBloc<OtpEvent, UserRegistrationData> {
  UserRegistrationBloc(
      this._eventBus, this._preferenceStore) : super(initState) {
    on<InitEvent>(_initEvent);
    _eventBus.events.listen(_handleBusEvents).bindToLifecycle(this);
  }

  final EventBus _eventBus;
  final PreferenceStore _preferenceStore;

  static UserRegistrationData get initState => (UserRegistrationDataBuilder()
        ..state = ScreenState.content
        ..countryCode=''
        ..phoneNumber=''
        ..getAddressType=null
        ..isValidOtp=false
        ..userType = null)
      .build();

  void _handleBusEvents(BusEvent it) async {
    switch (it.runtimeType) {}
  }

  Future<void> _initEvent(InitEvent event, emit) async {



  }



  @override
  Future<void> close() {
    return super.close();
  }
}
