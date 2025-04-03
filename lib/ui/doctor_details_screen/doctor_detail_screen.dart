import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../blocs/doctor_detail_screen/doctor_detail_bloc.dart';
import '../../blocs/doctor_detail_screen/doctor_detail_contract_contract.dart';
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
import '../common/app_network_image.dart';
import '../common/icon_image.dart';

class DoctorDetailScreen extends StatefulWidget {
  @override
  DoctorDetailScreenState createState() => DoctorDetailScreenState();
}

class DoctorDetailScreenState
    extends BaseState<DoctorDetailBloc, DoctorDetailScreen> {
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
        body: BlocProvider.value(
      value: bloc,
      child: BlocBuilder<DoctorDetailBloc, DoctorDetailData>(
        builder: (context, data) {
          switch (data.state) {
            case ScreenState.empty:
            case ScreenState.loading:
            case ScreenState.content:
              return _DoctorDetailBody(
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

class _DoctorDetailBody extends StatelessWidget {
  final DoctorDetailData data;
  final DoctorDetailBloc bloc;

  const _DoctorDetailBody({required this.data, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.scaffoldBackgroundColor,
        child: Container(
          child: Stack(
            children: [
              AppNetworkImage(
                url: 'https://picsum.photos/200/300',
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
              ),
              ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: (){
                              context.pop();
                            },
                            child: SvgPicture.asset(AppSvgImage.icBack)),
                        // IconImage(image: AppSvgImage.icShare,color: AppColors.white,edgeInsets: EdgeInsets.all(12),)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.white),
                          child: SvgPicture.asset(AppSvgImage.icShare),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.white),
                        child: SvgPicture.asset(AppSvgImage.icHeart),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                        color: AppColors.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24),
                            topLeft: Radius.circular(24))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Doctor Name ausg',
                                    style: AppFontTextStyles.textMedium
                                        .copyWith(
                                            fontSize: 24,
                                            color: AppColors.blackTextColor),
                                  ),
                                  Row(
                                    spacing: 5,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Designation',
                                        style: AppFontTextStyles.textNormal
                                            .copyWith(
                                                fontSize: 18,
                                                color:
                                                    AppColors.blackTextColor),
                                      ),
                                      Container(
                                        height: 18,
                                        width: 1,
                                        color: AppColors.blackTextColor,
                                      ),
                                      Text(
                                        'Location',
                                        style: AppFontTextStyles.textNormal
                                            .copyWith(
                                                fontSize: 18,
                                                color:
                                                    AppColors.blackTextColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ContainerBox(
                              shadowRequired: false,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              borderRadius: 20,
                              child: Row(
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
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          spacing: 6,
                          children: [
                            _ServiceDetailWidget(
                                title: '25', subTitle: 'Years of Experience'),
                            _ServiceDetailWidget(
                                title: '25', subTitle: 'Years of Experience'),
                            _ServiceDetailWidget(
                                title: '25', subTitle: 'Years of Experience')
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.dividerColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          BaseLocalization.currentLocalization().about,
                          maxLines: 2,
                          style: AppFontTextStyles.textNormal.copyWith(
                              fontSize: 14, color: AppColors.darkTextColor),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Experienced and compassionate veterinarian dedicated to providing the best care for your pets, from camels to cats. Specializing in animal health and well-being with a deep understanding of local pet needs.',
                          maxLines: 250,
                          style: AppFontTextStyles.textNormal.copyWith(
                              fontSize: 14, color: AppColors.blackTextColor),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Wrap(
                          runSpacing: 6,
                          direction: Axis.horizontal,
                          spacing: 4,

                          verticalDirection: VerticalDirection.down,
                          children: List.generate(8, (index) {
                            return ContainerBox(
                              shadowRequired: false,
                              borderRadius: 8,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Text(
                                'title',
                                maxLines: 2,
                                style: AppFontTextStyles.textNormal.copyWith(
                                    fontSize: 14,
                                    color: AppColors.blackTextColor),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.dividerColor,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(
                            BaseLocalization.currentLocalization().reviewAndRating.toUpperCase(),
                            maxLines: 2,
                            style: AppFontTextStyles.textNormal.copyWith(
                                fontSize: 14, color: AppColors.darkTextColor),
                          ),
                          ContainerBox(
                            padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                            borderRadius: 20,
                            color: AppColors.darkTextColor,
                            child: Row(children: [ Text(
                              BaseLocalization.currentLocalization().all.toUpperCase(),
                              maxLines: 2,
                              style: AppFontTextStyles.textMedium.copyWith(
                                  fontSize: 14, color: AppColors.white),
                            ),SvgPicture.asset(AppSvgImage.icWhiteArrow)],),

                          )

                        ],),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                            return  _RatingListWidget();


                        }, separatorBuilder: (context,index){
                         return const SizedBox(height: 10,);

                        }, itemCount: 5),
                        const SizedBox(
                          height: 14,
                        ),
                        ActionButton(title: BaseLocalization.currentLocalization().bookAnAppointment,backGroundColor: AppColors.appButtonBG,titleTextStyle: AppFontTextStyles.textMedium.copyWith(fontSize: 18),)
                      ],
                    ),
                    width: double.infinity,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class _ServiceDetailWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const _ServiceDetailWidget(
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ContainerBox(
        borderRadius: 12,
        shadowRequired: false,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 2,
              style: AppFontTextStyles.textMedium
                  .copyWith(fontSize: 24, color: AppColors.darkTextColor),
            ),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: AppFontTextStyles.textNormal
                  .copyWith(fontSize: 14, color: AppColors.blackTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingListWidget extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return ContainerBox(
      borderRadius: 12,
      shadowRequired: false,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Dr. Ahmed is amazing! He treated my cat with so much care and patience. Highly recommended!',
            maxLines: 10,
            style: AppFontTextStyles.textNormal
                .copyWith(fontSize: 16, color: AppColors.blackTextColor),
          ),
          const SizedBox(
            height: 12,
          ),
          const Divider(
            height: 1,
            color: AppColors.dividerColor,
          ),
          const SizedBox(
            height: 8,
          ),

          Row(children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(shape: BoxShape.circle),
               child:   const AppNetworkImage(
                 url: 'https://picsum.photos/200/300',
                 height: 32,
                 width: 32,
               ),

            ),
            const SizedBox(width: 7,),
            Expanded(
              child: Text(
                'UserName',
                maxLines: 10,
                style: AppFontTextStyles.textNormal
                    .copyWith(fontSize: 16, color: AppColors.blackTextColor),
              ),
            ),
            SvgPicture.asset(AppSvgImage.icRating),
            const SizedBox(width: 3,),
            Text(
              '3.8',
              style: AppFontTextStyles.textNormal
                  .copyWith(
                  fontSize: 14,
                  color: AppColors.blackTextColor),
            ),
          ],)
        ],
      ),
    );
  }
}
