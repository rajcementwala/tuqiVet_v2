import 'dart:async';
import '../../core/base_bloc.dart';
import '../../core/cache/preference_store.dart';
import '../../core/event_bus.dart';
import '../../core/screen_state.dart';
import 'owner_tab_home_data.dart';

class OwnerHomeTabBloc extends BaseBloc<OwnerHomeEvent, OwnerTabHomeData> {
  OwnerHomeTabBloc(this._eventBus, this._preferenceStore) : super(initState) {
    on<InitEvent>(_initEvent);
    on<OnLanguageChangeEvent>(_onLanguageChangeEvent);
    on<RedirectToDoctorListScreen>(_redirectToDoctorListScreen);
    _eventBus.events.listen(_handleBusEvents).bindToLifecycle(this);
  }

  final EventBus _eventBus;
  final PreferenceStore _preferenceStore;

  static OwnerTabHomeData get initState => (OwnerTabHomeDataBuilder()
        ..state = ScreenState.content).build();

  void _handleBusEvents(BusEvent it) async {
    switch (it.runtimeType) {}
  }

  Future<void> _initEvent(InitEvent event, emit) async {

  }

  Future<void> _onLanguageChangeEvent(OnLanguageChangeEvent event, emit) async {
    _eventBus.sendEvent(LanguageChangeBusEvent(event.language));
  }

  Future<void> _redirectToDoctorListScreen(RedirectToDoctorListScreen event, emit) async {

  }





}
