import 'dart:async';

import '../../core/base_bloc.dart';
import '../../core/error/failures.dart';
import '../../core/event_bus.dart';
import '../../core/screen_state.dart';
import '../../core/view_actions.dart';
import 'tab_bar_contract.dart';

class TabBarBloc extends BaseBloc<TabBarEvent, TabBarData> {
  TabBarBloc(this._errorHandler, this._eventBus) : super(initState) {
    _eventBus.events.listen(_handleBusEvents).bindToLifecycle(this);
  }

  final CustomErrorHandler _errorHandler;
  final EventBus _eventBus;

  static TabBarData get initState => (TabBarDataBuilder()
        ..state = ScreenState.content
        ..hasLocalAuthentication = false)
      .build();

  @override
  Stream<TabBarData> mapEventToState(TabBarEvent event) async* {
    if (event is InitEvent) {}
  }

  void _handleBusEvents(BusEvent it) async {
    switch (it.runtimeType) {
      case SignOutBusEvent:
        dispatchViewEvent(NavigateScreen(TabBarTarget.SPLASH));
        break;
    }
  }

}
