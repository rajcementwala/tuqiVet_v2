import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../blocs/owner_booking_tab_bloc/owner_booking_tab_bloc.dart';
import '../../blocs/owner_booking_tab_bloc/owner_booking_tab_data.dart';
import '../../core/base_state.dart';
import '../../core/constants.dart';
import '../../core/screen_state.dart';
import '../../core/utils/app_font_styles.dart';
import '../../core/utils/approuts.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/images.dart';
import '../../core/view_actions.dart';
import '../../extension/navigation_extensions.dart';
import '../../localizations/base_localization.dart';
import '../booking_details/booking_details_screen.dart';
import '../common/status_bar_view.dart';
import '../doctor_details_screen/doctor_detail_screen.dart';
import 'booking_tab_view.dart';

class OwnerBookingsTabScreen extends StatefulWidget {
  @override
  OwnerBookingsTabScreenState createState() => OwnerBookingsTabScreenState();
}

class OwnerBookingsTabScreenState
    extends BaseState<OwnerBookingTabBloc, OwnerBookingsTabScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController phoneController = TextEditingController();
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void onViewEvent(ViewAction event) {
    super.onViewEvent(event);

    if (event is NavigateScreen) {
      if(event.target==AppRoutes.bookingDetailsScreen){

        unawaited(
          navigatorKey. currentContext?.push(

            settings: const RouteSettings(
              name: AppRoutes.bookingDetailsScreen,
            ),
            builder: (context) => BookingDetailsScreen(),
          ),
        );
      }



    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            SvgPicture.asset(AppSvgImage.icBookingCalender),
            const SizedBox(
              width: 8,
            )
          ],
          backgroundColor: AppColors.white,
          centerTitle: true,
          titleTextStyle: AppFontTextStyles.textNormal
              .copyWith(fontSize: 16, color: AppColors.blackTextColor),
          title: Text(BaseLocalization.currentLocalization().bookings),
        ),
        body: BlocProvider.value(
          value: bloc,
          child: BlocBuilder<OwnerBookingTabBloc, OwnerTabBookingData>(
            builder: (context, data) {
              switch (data.state) {
                case ScreenState.empty:
                case ScreenState.loading:
                case ScreenState.content:
                  return _OwnerBookingBody(
                      bloc: bloc,
                      data: data,
                      controller: phoneController,
                      tabController: controller);
                default:
                  return Container();
              }
            },
          ),
        ));
  }
}

class _OwnerBookingBody extends StatelessWidget {
  final OwnerTabBookingData data;
  final OwnerBookingTabBloc bloc;
  final TextEditingController controller;
  final TabController tabController;

  const _OwnerBookingBody(
      {required this.data,
      required this.bloc,
      required this.controller,
      required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const StatusBarView(),
        PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Container(
            margin: const EdgeInsets.only(top: 1),
            color: AppColors.white,
            child: TabBar(
              dividerColor: Colors.transparent,
              indicatorColor: AppColors.primary,
              unselectedLabelStyle: AppFontTextStyles.textMedium
                  .copyWith(fontSize: 14, color: AppColors.blackTextColor),
              labelStyle: AppFontTextStyles.textMedium
                  .copyWith(fontSize: 14, color: AppColors.darkTextColor),
              tabs: [
                const Tab(text: 'Confirmed'),
                const Tab(text: 'Pending'),
                const Tab(text: 'Rejected'),
              ],
              controller: tabController,
            ),
          ),
        ),
        Expanded(
            child: TabBarView(
          children: [
            OwnerBookingTabView(
              callback: (v) {

                bloc.add(NavigateToBookingDetailsEvent());
              },
            ),
            OwnerBookingTabView(
              callback: (v) {

                bloc.add(NavigateToBookingDetailsEvent());

              },
            ),
            OwnerBookingTabView(
              callback: (v) {
                bloc.add(NavigateToBookingDetailsEvent());

              },

            )
          ],
          controller: tabController,
        ))
      ],
    );
  }

  Widget getBannerWidget(
      String title, String buttonTitle, String image, Function ontap) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            AppColors.appButtonBG,
            AppColors.darkBrown,
          ])),
      child: Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFontTextStyles.textMedium.copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(
                    buttonTitle,
                    style: AppFontTextStyles.textMedium.copyWith(
                        fontSize: 16,
                        color: AppColors.darkTextColor,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          Image.asset(
            image,
            height: 140,
          )
        ],
      ),
    );
  }
}
