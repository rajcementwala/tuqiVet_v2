import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../blocs/user_registration/user_registration_screen_bloc.dart';
import '../../blocs/user_registration/user_registration_screen_contract.dart';
import '../../core/base_state.dart';
import '../../core/screen_state.dart';
import '../../core/utils/app_font_styles.dart';
import '../../core/utils/approuts.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/enum.dart';
import '../../core/utils/images.dart';
import '../../extension/navigation_extensions.dart';
import '../../localizations/base_localization.dart';
import '../common/action_button.dart';
import '../common/app_text_field.dart';
import '../tab_bar/tab_bar_screen.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen();

  @override
  UserRegistrationScreenState createState() => UserRegistrationScreenState();
}

class UserRegistrationScreenState
    extends BaseState<UserRegistrationBloc, UserRegistrationScreen> {
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.add(InitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: SafeArea(
          child: BlocProvider.value(
            value: bloc,
            child: BlocBuilder<UserRegistrationBloc, UserRegistrationData>(
              builder: (context, data) {
                switch (data.state) {
                  case ScreenState.empty:
                  case ScreenState.loading:
                  case ScreenState.content:
                    return _UserRegistrationBody(
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

class _UserRegistrationBody extends StatelessWidget {
  final UserRegistrationData data;
  final UserRegistrationBloc bloc;
  final TextEditingController controller;

  const _UserRegistrationBody(
      {required this.data, required this.bloc, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16,left: 16,bottom: 16),
      child: Column(
        children: [
          InkWell(
            splashColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
            onTap: () {
              context.pop();
            },
            child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 15),
                  child: SvgPicture.asset(AppSvgImage.icBack),
                )),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    BaseLocalization.currentLocalization().createAccountTitle,
                    style: AppFontTextStyles.textMedium
                        .copyWith(fontSize: 32, color: AppColors.darkTextColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    '${BaseLocalization.currentLocalization().createAccountDescription} \n${data.countryCode} ${data.phoneNumber}',
                    maxLines: 3,
                    style: AppFontTextStyles.textNormal.copyWith(
                        fontSize: 16, color: AppColors.blackTextColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    BaseLocalization.currentLocalization().enterFullName,
                    style: AppFontTextStyles.textNormal.copyWith(
                        fontSize: 14, color: AppColors.blackTextColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  AppTextField(
                    type: TextFieldType.borderBox,
                    placeHolder: BaseLocalization.currentLocalization()
                        .enterYourFullName,
                    keyboardType: TextInputType.name,
                    onChanged: (s) {},
                    textEditingController: TextEditingController(),
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  Text(
                    BaseLocalization.currentLocalization().addressDetails,
                    style: AppFontTextStyles.textMedium
                        .copyWith(fontSize: 32, color: AppColors.darkTextColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          BaseLocalization.currentLocalization()
                              .addressDetailsDesc,
                          maxLines: 3,
                          style: AppFontTextStyles.textNormal.copyWith(
                              fontSize: 16, color: AppColors.blackTextColor),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.buttonBackground),
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          BaseLocalization.currentLocalization().openMap,
                          style: AppFontTextStyles.textMedium.copyWith(
                              fontSize: 16,
                              color: AppColors.darkTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    BaseLocalization.currentLocalization().saveAddressAs,
                    style: AppFontTextStyles.textNormal.copyWith(
                        fontSize: 14, color: AppColors.blackTextColor),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Wrap(
                    runSpacing: 6,
                    direction: Axis.horizontal,
                    spacing: 4,
                    verticalDirection: VerticalDirection.down,
                    children: List.generate(AddressType.values.length, (index) {
                      return _AddressWidget(
                          addressType: AddressType.values[index],
                          bloc: bloc,
                          data: data);
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    BaseLocalization.currentLocalization().city,
                    style: AppFontTextStyles.textNormal.copyWith(
                        fontSize: 14, color: AppColors.blackTextColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  AppTextField(
                    type: TextFieldType.borderBox,
                    placeHolder: BaseLocalization.currentLocalization().select,
                    keyboardType: TextInputType.name,
                    onChanged: (s) {},
                    suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SvgPicture.asset(AppSvgImage.icDropDown)),
                    textEditingController: TextEditingController(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    BaseLocalization.currentLocalization().city,
                    style: AppFontTextStyles.textNormal.copyWith(
                        fontSize: 14, color: AppColors.blackTextColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  AppTextField(
                    type: TextFieldType.borderBox,
                    placeHolder: BaseLocalization.currentLocalization().select,
                    keyboardType: TextInputType.name,
                    onChanged: (s) {},
                    suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SvgPicture.asset(AppSvgImage.icDropDown)),
                    textEditingController: TextEditingController(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    BaseLocalization.currentLocalization().district,
                    style: AppFontTextStyles.textNormal.copyWith(
                        fontSize: 14, color: AppColors.blackTextColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  AppTextField(
                    type: TextFieldType.borderBox,
                    placeHolder: BaseLocalization.currentLocalization().select,
                    keyboardType: TextInputType.name,
                    onChanged: (s) {},
                    suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SvgPicture.asset(AppSvgImage.icDropDown)),
                    textEditingController: TextEditingController(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    BaseLocalization.currentLocalization().street,
                    style: AppFontTextStyles.textNormal.copyWith(
                        fontSize: 14, color: AppColors.blackTextColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  AppTextField(
                    type: TextFieldType.borderBox,
                    placeHolder: BaseLocalization.currentLocalization().select,
                    keyboardType: TextInputType.name,
                    onChanged: (s) {},
                    isEnabled: true,
                    textEditingController: TextEditingController(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    BaseLocalization.currentLocalization().buildingType,
                    style: AppFontTextStyles.textNormal.copyWith(
                        fontSize: 14, color: AppColors.blackTextColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  AppTextField(
                    type: TextFieldType.borderBox,
                    placeHolder: BaseLocalization.currentLocalization().select,
                    keyboardType: TextInputType.name,
                    onChanged: (s) {},
                    suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SvgPicture.asset(AppSvgImage.icDropDown)),
                    textEditingController: TextEditingController(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            BaseLocalization.currentLocalization().buildingNumber,
                            style: AppFontTextStyles.textNormal.copyWith(
                                fontSize: 14, color: AppColors.blackTextColor),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          AppTextField(
                            type: TextFieldType.borderBox,
                            placeHolder:
                                BaseLocalization.currentLocalization().select,
                            keyboardType: TextInputType.name,
                            onChanged: (s) {},
                            textEditingController: TextEditingController(),
                          ),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            BaseLocalization.currentLocalization().floorNumber,
                            style: AppFontTextStyles.textNormal.copyWith(
                                fontSize: 14, color: AppColors.blackTextColor),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          AppTextField(
                            type: TextFieldType.borderBox,
                            placeHolder:
                                BaseLocalization.currentLocalization().select,
                            keyboardType: TextInputType.name,
                            onChanged: (s) {},
                            textEditingController: TextEditingController(),
                          ),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,

                            children: [
                          Text(
                            BaseLocalization.currentLocalization().apartmentNumber,
                            style: AppFontTextStyles.textNormal.copyWith(
                                fontSize: 14, color: AppColors.blackTextColor),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          AppTextField(
                            type: TextFieldType.borderBox,
                            placeHolder:
                                BaseLocalization.currentLocalization().select,
                            keyboardType: TextInputType.name,
                            onChanged: (s) {},
                            textEditingController: TextEditingController(),
                          ),
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    BaseLocalization.currentLocalization().abbreviationName,
                    style: AppFontTextStyles.textNormal.copyWith(
                        fontSize: 14, color: AppColors.blackTextColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  AppTextField(
                    type: TextFieldType.borderBox,
                    placeHolder: BaseLocalization.currentLocalization()
                        .enterAbbreviationName,
                    keyboardType: TextInputType.name,
                    onChanged: (s) {},
                    textEditingController: TextEditingController(),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ActionButton(
                    title: BaseLocalization.currentLocalization()
                        .lblContinue,

                    isEnabled: true,
                    titleTextStyle: AppFontTextStyles.textMedium,

                    onTap: () {
                      context.push(

                        settings: const RouteSettings(
                          name: AppRoutes.tabBarScreen,
                        ),
                        builder: (context) =>  const TabBarScreen(),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressWidget extends StatelessWidget {
  final AddressType addressType;
  final UserRegistrationBloc bloc;
  final UserRegistrationData data;

  const _AddressWidget(
      {super.key,
      required this.addressType,
      required this.bloc,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: data.getAddressType == addressType ? 2 : 0,
              color: data.getAddressType == addressType
                  ? AppColors.darkTextColor
                  : AppColors.white)),
      child: Row(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            addressType.iconFromEnum,
            colorFilter: ColorFilter.mode(
                data.getAddressType == addressType
                    ? AppColors.darkTextColor
                    : AppColors.blackTextColor,
                BlendMode.srcIn),
          ),
          Text(
            addressType.stringFromEnum,
            style: AppFontTextStyles.textNormal.copyWith(
                fontSize: 14,
                color: data.getAddressType == addressType
                    ? AppColors.darkTextColor
                    : AppColors.blackTextColor),
          ),
        ],
      ),
    );
  }
}
