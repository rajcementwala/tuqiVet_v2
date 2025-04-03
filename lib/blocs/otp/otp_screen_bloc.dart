import 'dart:async';
import '../../core/base_bloc.dart';
import '../../core/cache/preference_store.dart';
import '../../core/event_bus.dart';
import '../../core/screen_state.dart';
import '../../core/utils/approuts.dart';
import '../../core/utils/enum.dart';
import '../../core/view_actions.dart';
import 'otp_screen_contract.dart';

class OtpBloc extends BaseBloc<OtpEvent, OtpData> {
  OtpBloc(
      this._eventBus, this._preferenceStore) : super(initState) {
    on<InitEvent>(_initEvent);
    on<VerifyOtpEvent>(_onVerifyMobileNumberEvent);
    on<OTPChangedEvent>(_onOtpChangeEvent);
    _eventBus.events.listen(_handleBusEvents).bindToLifecycle(this);
  }

  final EventBus _eventBus;
  final PreferenceStore _preferenceStore;

  static OtpData get initState => (OtpDataBuilder()
        ..state = ScreenState.content
        ..countryCode=''
        ..phoneNumber=''
        ..isValidOtp=false
        ..userType = null)
      .build();

  void _handleBusEvents(BusEvent it) async {
    switch (it.runtimeType) {}
  }

  Future<void> _initEvent(InitEvent event, emit) async {

    emit(state.rebuild((updates){
      updates.countryCode=event.code;
      updates.phoneNumber=event.phoneNumber;
      updates.userType=UserTypeExtension.enumFromString(event.userType);
    }));

  }


   Future<void> _onVerifyMobileNumberEvent(VerifyOtpEvent event, emit) async {

    dispatchViewEvent(NavigateScreen(AppRoutes.userRegistrationScreen));

  }

  Future<void> _onOtpChangeEvent(OTPChangedEvent event, emit) async {
      emit(state.rebuild((updates){
        updates.isValidOtp=event.otp.length==6;
      }));
  }

}
