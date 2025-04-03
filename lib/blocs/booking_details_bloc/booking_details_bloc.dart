import 'dart:async';

import '../../core/base_bloc.dart';
import '../../core/cache/preference_store.dart';
import '../../core/error/failures.dart';
import '../../core/event_bus.dart';
import '../../core/screen_state.dart';
import '../../core/utils/approuts.dart';
import '../../core/view_actions.dart';
import 'booking_details_contract.dart';

class BookingDetailsBloc extends BaseBloc<BookingDetailsEvent, BookingDetailsScreenData> {
  BookingDetailsBloc(this._errorHandler, this._eventBus, this._preferenceStore)
      : super(initState) {
    on<InitEvent>(_initEvent);
    _eventBus.events.listen(_handleBusEvents).bindToLifecycle(this);
  }

  final CustomErrorHandler _errorHandler;
  final EventBus _eventBus;
  final PreferenceStore _preferenceStore;

  static BookingDetailsScreenData get initState => (BookingDetailsScreenDataBuilder()
        ..state = ScreenState.content
        ..hasLocalAuthentication = false)
      .build();

  void _handleBusEvents(BusEvent it) async {
    switch (it.runtimeType) {}
  }

  Future<void> _initEvent(InitEvent event, emit) async {

  }

  Future<void> _navigateToDoctorDetailsScreen(InitEvent event, emit) async {
      dispatchViewEvent(NavigateScreen(AppRoutes.doctorDetailScreen));
  }

}
