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
import '../doctor_details_screen/doctor_detail_screen.dart';

class DoctorListScreen extends StatefulWidget {
  @override
  DoctorListScreenState createState() => DoctorListScreenState();
}

class DoctorListScreenState
    extends BaseState<BookingDetailsBloc, DoctorListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void onViewEvent(ViewAction event) {
    super.onViewEvent(event);

    if (event is NavigateScreen) {
      if(event.target==AppRoutes.doctorDetailScreen){

        unawaited(
          navigatorKey. currentContext?.push(

            settings: const RouteSettings(
              name: AppRoutes.doctorDetailScreen,
            ),
            builder: (context) => DoctorDetailScreen(),
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
              height: 10,width: 10,
              AppSvgImage.icBack,
              fit: BoxFit.scaleDown,
            ),
          ),
          automaticallyImplyLeading:false,
          title:   Row(

            spacing: 10,
            mainAxisSize: MainAxisSize.min,

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(14)
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(AppSvgImage.icOtherLocation)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Location Name',style: AppFontTextStyles.textMedium.copyWith(fontSize: 16,color: AppColors.darkTextColor),),
                    Text('Location Addresshere',style: AppFontTextStyles.textNormal.copyWith(fontSize: 14,color: AppColors.blackTextColor),),
                  ],
                ),
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

  const _DoctorListBody({required this.data, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.scaffoldBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 14),
        child: ListView.separated(itemBuilder: (context,index){
          return              ContainerBox(

            onTap: (){
              unawaited(
                navigatorKey. currentContext?.push(

                  settings: const RouteSettings(
                    name: AppRoutes.doctorDetailScreen,
                  ),
                  builder: (context) => DoctorDetailScreen(),
                ),
              );

            },
            borderRadius: 14,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(14),bottomLeft: Radius.circular(14)),
                  child:

                  CachedNetworkImage(
                    height: 120,
                    width: 120,
                    fit: BoxFit.fill,
                    imageUrl: 'https://picsum.photos/200/300',
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                        CircularProgressIndicator(
                            value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        SvgPicture.asset(AppSvgImage.icLanguage),
                  ),
                ),
                Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child:
                      IntrinsicHeight(
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 8,),
                            Text(
                              'Doctor Name ausg',
                              style: AppFontTextStyles.textMedium
                                  .copyWith(
                                  fontSize: 18,
                                  color: AppColors.blackTextColor),
                            ),
                            Row(
                              spacing: 3,
                              children: [
                                Text(
                                  'Designation',
                                  style: AppFontTextStyles.textNormal
                                      .copyWith(
                                      fontSize: 14,
                                      color: AppColors.blackTextColor),
                                ),
                                Container(
                                  height: 12,
                                  width: 1,
                                  color: AppColors.blackTextColor,
                                ),
                                Text(
                                  'Location',
                                  style: AppFontTextStyles.textNormal
                                      .copyWith(
                                      fontSize: 14,
                                      color: AppColors.blackTextColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              spacing: 3,
                              children: [
                        
                                SvgPicture.asset(AppSvgImage.icRating),
                                Text(
                                  '3.8',
                                  style: AppFontTextStyles.textNormal
                                      .copyWith(
                                      fontSize: 14,
                                      color: AppColors.blackTextColor),
                                ),
                                Container(
                                  height: 12,
                                  width: 1,
                                  color: AppColors.blackTextColor,
                                ),
                                Text(
                                  '54 ${BaseLocalization.currentLocalization().reviews}',
                                  style: AppFontTextStyles.textNormal
                                      .copyWith(
                                      fontSize: 14,
                                      color: AppColors.blackTextColor),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Text(
                              '54 ${BaseLocalization.currentLocalization().sar}',
                              style: AppFontTextStyles.textMedium
                                  .copyWith(
                                  fontSize: 18,
                                  color: AppColors.darkTextColor),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          );

        }, separatorBuilder: (context,index){
          return const SizedBox(height: 10,);
        }, itemCount: 10));
  }
}

