import 'dart:async';

import '../../core/base_bloc.dart';
import '../../core/cache/preference_store.dart';
import '../../core/error/failures.dart';
import '../../core/event_bus.dart';
import '../../core/screen_state.dart';
import '../../core/utils/approuts.dart';
import '../../core/view_actions.dart';
import 'splash_contract.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashData> {
  SplashBloc(this._errorHandler, this._eventBus, this._preferenceStore)
      : super(initState) {
    on<InitEvent>(_initEvent);
    _eventBus.events.listen(_handleBusEvents).bindToLifecycle(this);
  }

  final CustomErrorHandler _errorHandler;
  final EventBus _eventBus;
  final PreferenceStore _preferenceStore;

  static SplashData get initState => (SplashDataBuilder()
        ..state = ScreenState.content
        ..hasLocalAuthentication = false)
      .build();

  void _handleBusEvents(BusEvent it) async {
    switch (it.runtimeType) {}
  }

  Future<void> _initEvent(InitEvent event, emit) async {
    await Future.delayed(const Duration(seconds: 3));
    if (_preferenceStore.getIsLoggedIn()) {
      dispatchViewEvent(NavigateScreen(AppRoutes.dashboardScreen));
    } else {
      dispatchViewEvent(NavigateScreen(AppRoutes.chooseRoleScreen));
    }
  }

}
