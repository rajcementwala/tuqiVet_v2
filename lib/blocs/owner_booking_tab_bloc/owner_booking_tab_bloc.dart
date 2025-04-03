import 'dart:async';
import '../../core/base_bloc.dart';
import '../../core/cache/preference_store.dart';
import '../../core/event_bus.dart';
import '../../core/screen_state.dart';
import '../../core/utils/approuts.dart';
import '../../core/view_actions.dart';
import 'owner_booking_tab_data.dart';


class OwnerBookingTabBloc extends BaseBloc<OwnerBookingEvent, OwnerTabBookingData> {
  OwnerBookingTabBloc(
      this._eventBus, this._preferenceStore) : super(initState) {
    on<InitEvent>(_initEvent);
    on<NavigateToBookingDetailsEvent>(_navigateToBookingDetailEvent);
    _eventBus.events.listen(_handleBusEvents).bindToLifecycle(this);
  }

  final EventBus _eventBus;
  final PreferenceStore _preferenceStore;

  static OwnerTabBookingData get initState => (OwnerTabBookingDataBuilder()
        ..state = ScreenState.content).build();

  void _handleBusEvents(BusEvent it) async {
    switch (it.runtimeType) {}
  }

  Future<void> _initEvent(InitEvent event, emit) async {



  }

  Future<void> _navigateToBookingDetailEvent(NavigateToBookingDetailsEvent event, emit) async {

    dispatchViewEvent(NavigateScreen(AppRoutes.bookingDetailsScreen));

  }





}
