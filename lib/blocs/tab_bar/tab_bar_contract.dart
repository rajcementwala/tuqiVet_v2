// ignore_for_file: constant_identifier_names
import 'package:built_value/built_value.dart';

import '../../core/screen_state.dart';

part 'tab_bar_contract.g.dart';


abstract class TabBarData implements Built<TabBarData, TabBarDataBuilder> {
  factory TabBarData([void Function(TabBarDataBuilder) updates]) = _$TabBarData;

  TabBarData._();

  ScreenState get state;

  String? get errorMessage;

  bool get hasLocalAuthentication;
}

abstract class TabBarEvent {}

class InitEvent extends TabBarEvent {}

class ErrorEvent extends TabBarEvent {
  ErrorEvent(this.errorMessage);

  final String? errorMessage;
}

abstract class TabBarTarget {
  static const String SPLASH = 'splash';
  static const String LOCAL_AUTHENTICATION_FAILURE =
      'local_authentication_failure';
}

/*
extension LagoTabExtension on AppTab {
  String get activeImage {
    switch (this) {
      case AppTab.home:
        return Images.tabHome;
      case AppTab.community:
        return Images.tabHome;
      case AppTab.collection:
        return Images.tabHome;
      case AppTab.frames:
        return Images.tabHome;
      case AppTab.profile:
        return Images.tabHome;
    }
  }

  String get inactiveImage {
    switch (this) {
      case AppTab.home:
        return Images.tabHome;
      case AppTab.community:
        return Images.tabHome;
      case AppTab.collection:
        return Images.tabHome;
      case AppTab.frames:
        return Images.tabHome;
      case AppTab.profile:
        return Images.tabHome;
    }
  }

  String get tabTitle {
    switch (this) {
      case AppTab.home:
        return 'TAB_HOME';
      case AppTab.community:
        return 'TAB_COMMUNITY';
      case AppTab.collection:
        return 'TAB_COLLECTION';
      case AppTab.frames:
        return 'TAB_FRAMES';
      case AppTab.profile:
        return 'TAB_PROFILE';
    }
  }
}
*/
