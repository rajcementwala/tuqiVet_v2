import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../blocs/booking_details_bloc/booking_details_bloc.dart';
import '../../blocs/booking_details_bloc/booking_details_contract.dart';

import '../../core/base_state.dart';
import '../../core/screen_state.dart';
import '../../core/utils/app_font_styles.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/container_box.dart';
import '../../core/utils/images.dart';
import '../../core/view_actions.dart';
import '../../extension/navigation_extensions.dart';
import '../../localizations/base_localization.dart';
import '../common/action_button.dart';

class BookingDetailsScreen extends StatefulWidget {
  @override
  BookingDetailsScreenState createState() => BookingDetailsScreenState();
}

class BookingDetailsScreenState
    extends BaseState<BookingDetailsBloc, BookingDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void onViewEvent(ViewAction event) {
    super.onViewEvent(event);

    if (event is NavigateScreen) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              context.pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                AppSvgImage.icBack,
              ),
            ),
          ),
          titleTextStyle: AppFontTextStyles.textNormal
              .copyWith(fontSize: 16, color: AppColors.blackTextColor),
          title: Text(BaseLocalization.currentLocalization().upcomingBookings),
        ),
        body: BlocProvider.value(
          value: bloc,
          child: BlocBuilder<BookingDetailsBloc, BookingDetailsScreenData>(
            builder: (context, data) {
              switch (data.state) {
                case ScreenState.empty:
                case ScreenState.loading:
                case ScreenState.content:
                  return _BookingDetailsBody(
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

class _BookingDetailsBody extends StatelessWidget {
  final BookingDetailsScreenData data;
  final BookingDetailsBloc bloc;

  const _BookingDetailsBody({required this.data, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.scaffoldBackgroundColor,

        child: Stack(
          children: [
            Container(
              color: AppColors.white,
              height: 74,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 14),
              child: ListView(
                children: [
                  ContainerBox(

                    borderRadius: 14,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(14),bottomLeft: Radius.circular(14)),
                          child: CachedNetworkImage(
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
                            child: Column(
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
                  ),
                  const SizedBox(height: 16,),
                  Text(
                    BaseLocalization.currentLocalization().bookingInformation,
                    style: AppFontTextStyles.textNormal
                        .copyWith(
                        fontSize: 14,
                        color: AppColors.blackTextColor),
                  ),
                  const SizedBox(height: 4,),

                  ContainerBox(
                    padding: const EdgeInsets.all(14),
                    borderRadius: 14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicHeight (
                          child: Row(
                            children: [
                              SvgPicture.asset(AppSvgImage.icCalenderWithBackground),
                              const SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '14 Feb 2025',
                                    style: AppFontTextStyles.textMedium
                                        .copyWith(
                                        fontSize: 18,
                                        color: AppColors.blackTextColor),
                                  ),
                                  Text(
                                    '${BaseLocalization.currentLocalization().time} 11:00 - 12:00',
                                    style: AppFontTextStyles.textNormal
                                        .copyWith(
                                        fontSize: 14,
                                        color: AppColors.blackTextColor),
                                  ),
                          
                          
                          
                                ],
                          
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  BaseLocalization.currentLocalization().pendingApproval,
                                  style: AppFontTextStyles.textMedium
                                      .copyWith(
                                      fontSize: 18,
                                      color: AppColors.orange),
                                ),
                              ),
                            ],
                          
                          ),
                        ),
                        const SizedBox(height:14,),

                         Divider(height: 2,color: AppColors.primary.withAlpha(20),),
                        const SizedBox(height:14,),
                        Text(
                          BaseLocalization.currentLocalization().numberOfAnimals,
                          style: AppFontTextStyles.textNormal
                              .copyWith(
                              fontSize: 14,
                              color: AppColors.blackTextColor),
                        ),

                        Text(
                          '2',
                          style: AppFontTextStyles.textMedium
                              .copyWith(
                              fontSize: 16,
                              color: AppColors.blackTextColor),
                        ),

                        const SizedBox(height:14,),
                        Text(
                          BaseLocalization.currentLocalization().visitType,
                          style: AppFontTextStyles.textNormal
                              .copyWith(
                              fontSize: 14,
                              color: AppColors.blackTextColor),
                        ),

                        Text(
                          'Test',
                          style: AppFontTextStyles.textMedium
                              .copyWith(
                              fontSize: 16,
                              color: AppColors.blackTextColor),
                        ),

                        const SizedBox(height:14,),
                        Text(
                          BaseLocalization.currentLocalization().place,
                          style: AppFontTextStyles.textNormal
                              .copyWith(
                              fontSize: 14,
                              color: AppColors.blackTextColor),
                        ),

                        Text(
                          'Test',
                          style: AppFontTextStyles.textMedium
                              .copyWith(
                              fontSize: 16,
                              color: AppColors.blackTextColor),
                        ),
                        const SizedBox(height:14,),
                        Text(
                          BaseLocalization.currentLocalization().complaintOrSymptoms,
                          style: AppFontTextStyles.textNormal
                              .copyWith(
                              fontSize: 14,
                              color: AppColors.blackTextColor),
                        ),

                        Text(
                          'Test',maxLines: 10,
                          style: AppFontTextStyles.textMedium
                              .copyWith(
                              fontSize: 16,
                              color: AppColors.blackTextColor),
                        ),
                      ],

                    ),

                  ),
                  const SizedBox(height: 16,),

                  Text(
                    BaseLocalization.currentLocalization().invoiceDetails,
                    style: AppFontTextStyles.textNormal
                        .copyWith(
                        fontSize: 14,
                        color: AppColors.blackTextColor),
                  ),
                  const SizedBox(height: 4,),
                  ContainerBox(
                    padding: const EdgeInsets.all(14),
                    borderRadius: 14,
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${BaseLocalization.currentLocalization().animal} x 2',
                              style: AppFontTextStyles.textNormal
                                  .copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackTextColor),
                            ),
                            const Spacer(),
                            Text(
                              '30 ${BaseLocalization.currentLocalization().sar}',
                              style: AppFontTextStyles.textNormal
                                  .copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackTextColor),
                            )
                          ],

                        ),
                        Row(
                          children: [
                            Text(
                              BaseLocalization.currentLocalization().serviceCharge,
                              style: AppFontTextStyles.textNormal
                                  .copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackTextColor),
                            ),
                            const Spacer(),
                            Text(
                              '30 ${BaseLocalization.currentLocalization().sar}',
                              style: AppFontTextStyles.textNormal
                                  .copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackTextColor),
                            )
                          ],

                        ),
                        Row(
                          children: [
                            Text(
                              BaseLocalization.currentLocalization().platformCharge,
                              style: AppFontTextStyles.textNormal
                                  .copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackTextColor),
                            ),
                            const Spacer(),
                            Text(
                              '30 ${BaseLocalization.currentLocalization().sar}',
                              style: AppFontTextStyles.textNormal
                                  .copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackTextColor),
                            )
                          ],

                        ), Row(
                          children: [
                            Text(
                              BaseLocalization.currentLocalization().total,
                              style: AppFontTextStyles.textMedium
                                  .copyWith(
                                  fontSize: 16,
                                  color: AppColors.darkTextColor),
                            ),
                            const Spacer(),
                            Text(
                              '30 ${BaseLocalization.currentLocalization().sar}',
                              style: AppFontTextStyles.textMedium
                                  .copyWith(
                                  fontSize: 16,
                                  color: AppColors.darkTextColor),

                            )
                          ],

                        ),
                      ],

                    ),

                  ),
                  const SizedBox(height: 16,),
                  ActionButton(title: BaseLocalization.currentLocalization().addReview
                  ,titleTextStyle: AppFontTextStyles.textMedium.copyWith(fontSize: 16),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

