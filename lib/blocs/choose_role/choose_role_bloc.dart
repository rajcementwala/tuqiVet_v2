import 'dart:async';
import '../../core/base_bloc.dart';
import '../../core/cache/preference_store.dart';
import '../../core/error/failures.dart';
import '../../core/event_bus.dart';
import '../../core/screen_state.dart';
import '../../core/utils/approuts.dart';
import '../../core/utils/enum.dart';
import '../../core/view_actions.dart';
import 'choose_role_contract.dart';

class ChooseRoleBloc extends BaseBloc<ChooseRoleEvent, ChooseRoleData> {
  ChooseRoleBloc(this._errorHandler, this._eventBus, this._preferenceStore)
      : super(initState) {
    on<InitEvent>(_initEvent);
    on<OnRoleSelectionEvent>(_onRoleSelectionEvent);
    on<RedirectToLoginScreenEvent>(_redirectToLoginScreenEvent);
    _eventBus.events.listen(_handleBusEvents).bindToLifecycle(this);
  }

  final CustomErrorHandler _errorHandler;
  final EventBus _eventBus;
  final PreferenceStore _preferenceStore;

  static ChooseRoleData get initState => (ChooseRoleDataBuilder()
        ..state = ScreenState.content
        ..hasLocalAuthentication = false)
      .build();

  void _handleBusEvents(BusEvent it) async {
    switch (it.runtimeType) {}
  }

  Future<void> _initEvent(InitEvent event, emit) async {}

  Future<void> _onRoleSelectionEvent(OnRoleSelectionEvent event, emit) async {
    emit(state.rebuild((updates) {
      updates.userType = event.userType;
    }));
  }


  Future<void> _redirectToLoginScreenEvent(
      RedirectToLoginScreenEvent event, emit) async {
    if (state.userType != null) {
      await _preferenceStore.setCurrentRole(state.userType!.stringFromEnum);
      dispatchViewEvent(NavigateScreen(AppRoutes.loginScreen));
    }
  }

}
