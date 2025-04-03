import 'package:flutter/material.dart';
import 'package:get_localization/get_localization.dart';

import '../../core/base_bloc.dart';
import '../../core/cache/preference_store.dart';
import '../../core/event_bus.dart';
import '../../core/screen_state.dart';
import '../../core/view_actions.dart';
import '../../localizations/ar.dart';
import '../../localizations/en.dart';
import '../../services/main_app/theme_service.dart';
import 'main_app_contract.dart';

class MainAppBloc extends BaseBloc<MainAppEvent, MainAppData> {
  MainAppBloc(this._themeService, this._eventBus, this._preferenceStore) : super(initState) {
    _eventBus.events.listen(_handleBusEvents).bindToLifecycle(this);

    on<InitEvent>(_initEvent);
    on<ChangeThemeEvent>(_changeTheme);
    on<ChangeLocaleEvent>(_changeLocale);
  }

  final ThemeService _themeService;
  final EventBus _eventBus;
  final PreferenceStore _preferenceStore;

  static MainAppData get initState => (MainAppDataBuilder()
        ..state = ScreenState.content
        ..local=const Locale('en')
        ..appThemeData = ThemeData.light())
      .build();


  void _initEvent(_, emit) => emit(



      state.rebuild((u) {
        if(_preferenceStore.getCurrentLocal()=='ar'){
          Localization.currentLocalization=ArabicLocalization();

        }else{
          Localization.currentLocalization=EnglishLocalization();

        }
        //u.appThemeData = _themeService.getThemeData();
        u.local=Locale(_preferenceStore.getCurrentLocal());
      } ));


  void _changeLocale(ChangeLocaleEvent event, emit) => emit(
      state.rebuild((u) => u..local = event.locale));

  void _changeTheme(_, emit) {
    emit(state.rebuild((u) {
      _themeService.changeTheme();
      u.appThemeData = _themeService.getThemeData();
    }));
    dispatchViewEvent(ChangeTheme());
  }
  void _handleBusEvents(BusEvent event) {
    switch (event.runtimeType) {
      case const (LanguageChangeBusEvent):
        final busEvent = event as LanguageChangeBusEvent;
        add(
          ChangeLocaleEvent(Locale( busEvent.language)),
        );
        break;

    }
  }
}
