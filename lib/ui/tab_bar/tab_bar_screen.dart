
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../blocs/tab_bar/tab_bar_bloc.dart';
import '../../blocs/tab_bar/tab_bar_contract.dart';
import '../../core/base_state.dart';
import '../../core/screen_state.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/enum.dart';
import '../../core/utils/styles.dart';
import '../../core/view_actions.dart';
import '../../extension/navigation_extensions.dart';
import '../common/full_screen_error.dart';
import '../common/full_screen_loader.dart';
import '../tab_bookings_owner/tab_bookings_owner.dart';
import '../tab_chat/tab_chat_screen.dart';
import '../tab_home_owner/tab_home_owner.dart';
import '../tab_profile/tab_profile_screen.dart';
import 'navigator_page.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends BaseState<TabBarBloc, TabBarScreen> {
  @override
  void initState() {

    super.initState();
  //  bloc.add(InitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => bloc,
      child: BlocBuilder<TabBarBloc, TabBarData>(
          builder: (BuildContext context, TabBarData data) {
        return _TabBarContent(data: data);
      }),
    );
  }

  @override
  void onViewEvent(ViewAction event) async {
    switch (event.runtimeType) {
      case NavigateScreen:
        final screen = event as NavigateScreen;
        switch (screen.target) {

        }
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _TabBarContent extends StatelessWidget {
  const _TabBarContent({required this.data, Key? key}) : super(key: key);

  final TabBarData data;

  @override
  Widget build(BuildContext context) {
    switch (data.state) {
      case ScreenState.loading:
        return const FullScreenLoader();
      case ScreenState.content:
        return const _TabBarSection();
      default:
        return FullScreenError(message: data.errorMessage!, onRetryTap: () {});
    }
  }
}

class _TabBarSection extends StatefulWidget {
  const _TabBarSection();

  @override
  State<_TabBarSection> createState() => _TabBarSectionState();
}

class _TabBarSectionState extends State<_TabBarSection> {
  AppTab _selectedTab = AppTab.home;

  final Map<AppTab, GlobalKey> _navigatorKeys = {
    AppTab.home: GlobalKey(),
    AppTab.bookings: GlobalKey(),
    AppTab.chat: GlobalKey(),
    AppTab.profile: GlobalKey(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: WillPopScope(
        onWillPop: () async {
          return !await context.maybePop();
        },
        child: IndexedStack(
          index: _selectedTab.index,
          children: <Widget>[
            NavigatorPage(
              child: OwnerHomeTabScreen(),
              navigatorKey: _navigatorKeys[AppTab.home],
            ),
            NavigatorPage(
              child: OwnerBookingsTabScreen(),
              navigatorKey: _navigatorKeys[AppTab.bookings],
            ),
            NavigatorPage(
              child: ChatTabScreen(),
              navigatorKey: _navigatorKeys[AppTab.chat],
            ),
            NavigatorPage(
              child: ProfileTabScreen(),
              navigatorKey: _navigatorKeys[AppTab.profile],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: Stack(
          children: [
            BottomNavigationBar(
                selectedItemColor: AppColors.primary,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: TextStyles.textNormal,
                unselectedLabelStyle: TextStyles.textNormal,
                iconSize: Dimens.icon_size_normal,
                items: _tabItems(),
                backgroundColor: AppColors.white,
                showUnselectedLabels:false,
                currentIndex: _selectedTab.index,
                onTap: _onTabBarIconTap),

            Positioned(
              top: 0,
              left: (_selectedTab.index * MediaQuery.of(context).size.width / 4) + 16,
              child: Container(
                decoration: BoxDecoration( color: AppColors.appButtonBG,borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width / 4 - 32,
                height: 4,

              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTabBarIconTap(int index) {
    setState(() {
      _selectedTab = AppTab.values[index];
    });
  }

  List<BottomNavigationBarItem> _tabItems() {
    return AppTab.values.map((AppTab tab) {
      return BottomNavigationBarItem(
        icon: _TabIcon(tab.inactiveImage),
        activeIcon: _TabIcon(tab.activeImage),
        label: tab.tabTitle,
      );
    }).toList();
  }
}

class _TabIcon extends StatelessWidget {
  final String icon;

  const _TabIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_xsmall),
      child: SvgPicture.asset(icon),
    );
  }
}
