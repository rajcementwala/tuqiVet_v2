import 'dart:async';
import '../../core/base_bloc.dart';
import '../../core/cache/preference_store.dart';
import '../../core/event_bus.dart';
import '../../core/screen_state.dart';
import '../../core/utils/enum.dart';
import '../../localizations/base_localization.dart';
import '../../services/on_boarding/on_boarding_service.dart';
import 'login_screen_contract.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginData> {
  LoginBloc(this._eventBus, this._preferenceStore, this._onBoardingService) : super(initState) {
    on<InitEvent>(_initEvent);
    on<OnSelectedCountryCodeEvent>(_onSelectedCountryCodeEvent);
    on<VerifyMobileNumberEvent>(_onVerifyMobileNumberEvent);
    _eventBus.events.listen(_handleBusEvents).bindToLifecycle(this);
  }

  final EventBus _eventBus;
  final PreferenceStore _preferenceStore;
  final OnBoardingService _onBoardingService;

  static LoginData get initState => (LoginDataBuilder()
        ..state = ScreenState.content
        ..userType = null)
      .build();

  void _handleBusEvents(BusEvent it) async {
    switch (it.runtimeType) {}
  }

  Future<void> _initEvent(InitEvent event, emit) async {
    var userType = _preferenceStore.getCurrentRole();
    emit(state.rebuild((updates) {
      updates.userType = UserTypeExtension.enumFromString(userType);
      updates.countryInfo = event.countryInfo;
    }));
  }

  Future<void> _onSelectedCountryCodeEvent(
      OnSelectedCountryCodeEvent event, emit) async {
    emit(state.rebuild((updates) {
      updates.countryInfo = event.countryInfo;
    }));

  }

  Future<void> _onVerifyMobileNumberEvent(
      VerifyMobileNumberEvent event, emit) async {
    if (event.phoneNumber.isEmpty || event.phoneNumber.length < 10) {
      emit(state.rebuild((updates) {
        updates.isValidMobileNumber = false;
        if (event.phoneNumber.isEmpty) {
          updates.errorMessage =
              BaseLocalization.currentLocalization().pleaseEnterPhone;
        } else {
          updates.errorMessage =
              BaseLocalization.currentLocalization().enterValidPhone;
        }
      }));
    } else {
      var data = {

        'phoneNumber':event.phoneNumber,
        'type': state.userType?.getUserTypeId
      };

     // dispatchViewEvent(NavigateScreen(AppRoutes.otpScreen, data: data));

      var response = await _onBoardingService.login(data);
      emit(state.rebuild((updates) {
        updates.isValidMobileNumber = true;
        updates.errorMessage = null;
      }));
    }
  }

}
