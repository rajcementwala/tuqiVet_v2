import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../blocs/owner_home_tab_bloc/owner_home_tab_bloc.dart';
import '../../blocs/owner_home_tab_bloc/owner_tab_home_data.dart';
import '../../core/base_state.dart';
import '../../core/constants.dart';
import '../../core/screen_state.dart';
import '../../core/utils/app_font_styles.dart';
import '../../core/utils/approuts.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/container_box.dart';
import '../../core/utils/enum.dart';
import '../../core/utils/images.dart';
import '../../core/view_actions.dart';
import '../../extension/navigation_extensions.dart';
import '../../localizations/base_localization.dart';
import '../common/app_text_field.dart';
import '../common/booking_list_item.dart';
import '../doctor_list_screen/doctor_list_screen.dart';
import '../tab_chat/select_animal_bottomsheet_widget.dart';
import '../vetenary_care_selection_screen/vetenary_case_selection_screen.dart';
import 'language_bottomsheet_widget.dart';

class OwnerHomeTabScreen extends StatefulWidget {
  @override
  OwnerHomeTabScreenState createState() => OwnerHomeTabScreenState();
}

class OwnerHomeTabScreenState
    extends BaseState<OwnerHomeTabBloc, OwnerHomeTabScreen> {
  TextEditingController phoneController = TextEditingController();

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
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: SafeArea(
          child: BlocProvider.value(
            value: bloc,
            child: BlocBuilder<OwnerHomeTabBloc, OwnerTabHomeData>(
              builder: (context, data) {
                switch (data.state) {
                  case ScreenState.empty:
                  case ScreenState.loading:
                  case ScreenState.content:
                    return _OwnerHomeBody(
                        bloc: bloc, data: data, controller: phoneController);
                  default:
                    return Container();
                }
              },
            ),
          ),
        ));
  }
}

class _OwnerHomeBody extends StatelessWidget {
  final OwnerTabHomeData data;
  final OwnerHomeTabBloc bloc;
  final TextEditingController controller;

  const _OwnerHomeBody(
      {required this.data, required this.bloc, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                      useRootNavigator: true,
                      context: context, builder: (context){
                    return LanguageBottomSheetWidget(onSelectionCallBack: (list){

                    });

                  });

                },

                child: ContainerBox(
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                  borderRadius: 14,
                  child: SvgPicture.asset(AppSvgImage.icLanguage),
                ),
              ),
              ContainerBox(
                padding: const EdgeInsets.all(12),
                borderRadius: 14,
                alignment: Alignment.center,
                child: SvgPicture.asset(AppSvgImage.icNotification),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          const SizedBox(
            height: 16,
          ),
          AppTextField(
            textEditingController: TextEditingController(),
            prefixIcon: SvgPicture.asset(AppSvgImage.icSearch),
            type: TextFieldType.borderBox,
            placeHolder:
                BaseLocalization.currentLocalization().searchYourKeyword,
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView(
              children: [
                getBannerWidget(
                    BaseLocalization.currentLocalization().veterinaryVisit,
                    BaseLocalization.currentLocalization().bookVisit,
                    AppImages.ivVisit, () {
                  navigatorKey.currentContext?.push(
                    settings: const RouteSettings(
                      name: AppRoutes.doctorListScreen,
                    ),
                    builder: (context) => VeterinaryCareSelectionScreen(),
                  );
                 // bloc.add(ShowAnimalBottomSheetEvent());
                }),
                const SizedBox(
                  height: 10,
                ),
                getBannerWidget(
                    BaseLocalization.currentLocalization().veterinaryCare,
                    BaseLocalization.currentLocalization().getCare,
                    AppImages.ivVeterinaryCare, () {
                  showModalBottomSheet(useRootNavigator: true, isScrollControlled: true,context: context, builder: (context){

                    return Container(
                        height: MediaQuery.of(context).size.height * 0.65,

                        child: SelectAnimalBottomSheetWidget(onSelectionCallBack: (list){

                          Navigator.pop(context);
                          navigatorKey.currentContext?.push(
                            settings: const RouteSettings(
                              name: AppRoutes.doctorListScreen,
                            ),
                            builder: (context) => DoctorListScreen(),
                          );
                        }


                        ));

                  });


                  // bloc.add(ShowAnimalBottomSheetEvent());
                }),
                const SizedBox(
                  height: 10,
                ),
                getBannerWidget(
                    BaseLocalization.currentLocalization().consultation,
                    BaseLocalization.currentLocalization().consultNow,
                    AppImages.ivConsultation, () {
                  //bloc.add(ShowAnimalBottomSheetEvent());
                  showModalBottomSheet(useRootNavigator: true, isScrollControlled: true,context: context, builder: (context){

                    return Container(
                        height: MediaQuery.of(context).size.height * 0.65,

                        child: SelectAnimalBottomSheetWidget(onSelectionCallBack: (list){

                          Navigator.pop(context);
                          navigatorKey.currentContext?.push(
                            settings: const RouteSettings(
                              name: AppRoutes.doctorListScreen,
                            ),
                            builder: (context) => DoctorListScreen(),
                          );
                        }


                        ));

                  });

                }),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      BaseLocalization.currentLocalization().upcomingVisit,
                      style: AppFontTextStyles.textMedium.copyWith(
                          fontSize: 20, color: AppColors.blackTextColor),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackground,
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        spacing: 3,
                        children: [
                          Text(
                            BaseLocalization.currentLocalization().all,
                            style: AppFontTextStyles.textMedium.copyWith(
                                fontSize: 16,
                                color: AppColors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          SvgPicture.asset(AppSvgImage.icWhiteArrow)
                        ],
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                const SizedBox(
                  height: 16,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BookingListItem(callback: (v){

                      },);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: 3),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Text(
                      BaseLocalization.currentLocalization().updateThisWeek,
                      style: AppFontTextStyles.textMedium.copyWith(
                          fontSize: 20, color: AppColors.blackTextColor),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackground,
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        spacing: 3,
                        children: [
                          Text(
                            BaseLocalization.currentLocalization().all,
                            style: AppFontTextStyles.textMedium.copyWith(
                                fontSize: 16,
                                color: AppColors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          SvgPicture.asset(AppSvgImage.icWhiteArrow)
                        ],
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Designation',
                                  style: AppFontTextStyles.textMedium.copyWith(
                                      fontSize: 18,
                                      color: AppColors.darkTextColor),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'Camels are more than just the ships of the desert—they are symbols of endurance, grace, and deep cultural heritage.',
                                  maxLines: 5,
                                  style: AppFontTextStyles.textNormal.copyWith(
                                      fontSize: 14,
                                      color: AppColors.blackTextColor),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 2,
                        child: CachedNetworkImage(
                          height: 180,
                          width: 135,
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
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getBannerWidget(String title, String buttonTitle, String image,
      GestureTapCallback ontap) {
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
                InkWell(
                  onTap: ontap,
                  child: Container(
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
