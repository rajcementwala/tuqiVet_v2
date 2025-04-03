import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../blocs/booking_details_bloc/booking_details_bloc.dart';
import '../../blocs/booking_details_bloc/booking_details_contract.dart';

import '../../core/base_state.dart';
import '../../core/constants.dart';
import '../../core/screen_state.dart';
import '../../core/utils/app_font_styles.dart';
import '../../core/utils/approuts.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/container_box.dart';
import '../../core/utils/images.dart';
import '../../core/view_actions.dart';
import '../../extension/navigation_extensions.dart';
import '../../localizations/base_localization.dart';
import '../common/action_button.dart';
import '../doctor_details_screen/doctor_detail_screen.dart';
import '../doctor_list_screen/doctor_list_screen.dart';

class VeterinaryCareSelectionScreen extends StatefulWidget {
  @override
  VeterinaryCareSelectionScreenState createState() =>
      VeterinaryCareSelectionScreenState();
}

class VeterinaryCareSelectionScreenState
    extends BaseState<BookingDetailsBloc, VeterinaryCareSelectionScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void onViewEvent(ViewAction event) {
    super.onViewEvent(event);
    if (event is NavigateScreen) {
      if (event.target == AppRoutes.doctorListScreen) {
        unawaited(
          navigatorKey.currentContext?.push(
            settings: const RouteSettings(
              name: AppRoutes.doctorListScreen,
            ),
            builder: (context) => DoctorListScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: InkWell(
            onTap: () {
              context.pop();
            },
            child: SvgPicture.asset(
              height: 10,
              width: 10,
              AppSvgImage.icBack,
              fit: BoxFit.scaleDown,
            ),
          ),
          title: Row(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: AppColors.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(AppSvgImage.icOtherLocation)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location Name',
                    style: AppFontTextStyles.textMedium
                        .copyWith(fontSize: 16, color: AppColors.darkTextColor),
                  ),
                  Text(
                    'Location Addresshere',
                    style: AppFontTextStyles.textNormal.copyWith(
                        fontSize: 14, color: AppColors.blackTextColor),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: BlocProvider.value(
          value: bloc,
          child: BlocBuilder<BookingDetailsBloc, BookingDetailsScreenData>(
            builder: (context, data) {
              switch (data.state) {
                case ScreenState.empty:
                case ScreenState.loading:
                case ScreenState.content:
                  return _DoctorListBody(
                    bloc: bloc,
                    data: data,
                    controller: controller,
                  );
                default:
                  return Container();
              }
            },
          ),
        ));
  }
}

class _DoctorListBody extends StatelessWidget {
  final BookingDetailsScreenData data;
  final BookingDetailsBloc bloc;
  final TabController controller;

  const _DoctorListBody(
      {required this.data, required this.bloc, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  BaseLocalization.currentLocalization().veterinaryCareSingle,
                  style: AppFontTextStyles.textMedium
                      .copyWith(fontSize: 20, color: AppColors.blackTextColor),
                ),
                SvgPicture.asset(AppSvgImage.icFilter)
              ],
            ),
          ),
          TabBar(
              unselectedLabelStyle: AppFontTextStyles.textMedium
                  .copyWith(color: AppColors.blackTextColor, fontSize: 14),
              labelStyle: AppFontTextStyles.textMedium
                  .copyWith(color: AppColors.darkTextColor, fontSize: 14),
              indicatorColor: AppColors.appButtonBG,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
              indicatorSize: TabBarIndicatorSize.tab,
              controller: controller,
              tabs: [
                const Tab(text: 'Individual'),
                const Tab(text: 'Package')
              ]),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select services that you want do with your animal.',
                      style: AppFontTextStyles.textNormal.copyWith(
                          fontSize: 14, color: AppColors.blackTextColor),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      'Select package that you want do with your animal.',
                      style: AppFontTextStyles.textNormal.copyWith(
                          fontSize: 14, color: AppColors.blackTextColor),
                    )
                  ],
                ),
              )
            ],
            controller: controller,
          )),
          const SizedBox(
            height: 20,
          ),
          ActionButton(title: BaseLocalization.currentLocalization().continueAsGuest)
        ],
      ),
    );
  }
}

class _ServiceListWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: const Row(
          children: [
            
            Expanded(child: Text('',style: AppFontTextStyles.textNormal,))
          ],
          
        ),
        
      );
  }
  
}


