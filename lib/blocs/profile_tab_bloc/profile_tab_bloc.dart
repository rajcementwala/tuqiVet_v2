import 'dart:async';

import '../../core/base_bloc.dart';
import '../../core/cache/preference_store.dart';
import '../../core/error/failures.dart';
import '../../core/event_bus.dart';
import '../../core/screen_state.dart';
import 'profile_tab_contract.dart';

class ProfileTabBloc extends BaseBloc<SplashEvent, ProfileTabData> {
  ProfileTabBloc(this._errorHandler, this._eventBus, this._preferenceStore)
      : super(initState) {
    on<InitEvent>(_initEvent);
    _eventBus.events.listen(_handleBusEvents).bindToLifecycle(this);
  }

  final CustomErrorHandler _errorHandler;
  final EventBus _eventBus;
  final PreferenceStore _preferenceStore;

  static ProfileTabData get initState => (ProfileTabDataBuilder()
        ..state = ScreenState.content
        ..hasLocalAuthentication = false)
      .build();

  void _handleBusEvents(BusEvent it) async {
    switch (it.runtimeType) {}
  }

  Future<void> _initEvent(InitEvent event, emit) async {

  }

}
