import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../blocs/login/login_screen_bloc.dart';
import '../../blocs/login/login_screen_contract.dart';
import '../../core/base_state.dart';
import '../../core/screen_state.dart';
import '../../core/utils/app_font_styles.dart';
import '../../core/utils/approuts.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/container_box.dart';
import '../../core/utils/enum.dart';
import '../../core/utils/images.dart';
import '../../core/view_actions.dart';
import '../../extension/navigation_extensions.dart';
import '../../extension/string_extensions.dart';
import '../../localizations/base_localization.dart';
import '../common/action_button.dart';
import '../common/app_text_field.dart';
import '../common/countrypicker/countries_info.dart';
import '../common/countrypicker/country_picker.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends BaseState<LoginBloc, LoginScreen> {
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final country = CountriesInfo().getCountryInfoByPhoneCode('+966');
    if (country != null) {
      bloc.add(
        InitEvent(country),
      );
    }
  }

  @override
  void onViewEvent(ViewAction event) {

    super.onViewEvent(event);
    if(event is NavigateScreen){
      if(event.target==AppRoutes.otpScreen){
        var data = event.data as Map<String,String>;

        unawaited(
          context.push(

            settings: const RouteSettings(
              name: AppRoutes.otpScreen,
            ),
            builder: (context) =>  OtpScreen(code: data['code']??'',phoneNumber: data['phoneNumber']??'',userType: data['userType']??'',),
          ),
        );
      }

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: SafeArea(
          child: BlocProvider.value(
            value: bloc,
            child: BlocBuilder<LoginBloc, LoginData>(
              builder: (context, data) {
                switch (data.state) {
                  case ScreenState.empty:
                  case ScreenState.loading:
                  case ScreenState.content:
                    return _ChooseRoleBody(
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

class _ChooseRoleBody extends StatelessWidget {
  final LoginData data;
  final LoginBloc bloc;
  final TextEditingController controller;

  const _ChooseRoleBody({required this.data,
    required this.bloc,
    required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,bottom: 30),
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
            onTap: (){
      
              context.pop();
            },
            child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
                  child: SvgPicture.asset(AppSvgImage.icBack),
                )),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  BaseLocalization
                      .currentLocalization()
                      .getStarted,
                  style: AppFontTextStyles.textMedium
                      .copyWith(fontSize: 32, color: AppColors.darkTextColor),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  BaseLocalization
                      .currentLocalization()
                      .loginDescription,
                  maxLines: 3,
                  style: AppFontTextStyles.textNormal
                      .copyWith(fontSize: 16, color: AppColors.blackTextColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  BaseLocalization
                      .currentLocalization()
                      .phone,
                  style: AppFontTextStyles.textNormal
                      .copyWith(fontSize: 14, color: AppColors.blackTextColor),
                ),
                const SizedBox(
                  height: 6,
                ),
                _MobileNoTextField(
                  data: data,
                  bloc: bloc,
                  mobileTextEditingController: controller,
                ),
      
                if(data.errorMessage.isNotNullOrEmpty)
                  Text(
                    data.errorMessage ?? '',
                    style: AppFontTextStyles.textNormal
                        .copyWith(fontSize: 14, color: AppColors.errorColor),
                  ),
      
                const SizedBox(
                  height: 44,
                ),

                Text(
                  BaseLocalization
                      .currentLocalization()
                      .continueAgreeTo,
                  maxLines: 3,
                  style: AppFontTextStyles.textNormal
                      .copyWith(fontSize: 16, color: AppColors.darkTextColor),
                ),
                Text(
                  BaseLocalization
                      .currentLocalization()
                      .termsAndCondition,
                  style: AppFontTextStyles.textNormal
                      .copyWith(fontSize: 16, color: AppColors.blackTextColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                ActionButton(
                  title: BaseLocalization
                      .currentLocalization()
                      .lblContinue,
                  isEnabled: true,
                  titleTextStyle: AppFontTextStyles.textMedium,
                  onTap: () {
                    bloc.add(VerifyMobileNumberEvent(controller.text));
                  },
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 40),
            decoration: BoxDecoration(border: Border.all(width: 1,color: AppColors.buttonBackground),
            borderRadius: BorderRadius.circular(25)
            ),
            child: Text( BaseLocalization
                .currentLocalization()
                .continueAsGuest,
              style: AppFontTextStyles.textMedium
                  .copyWith(fontSize: 16, color: AppColors.darkTextColor,fontWeight: FontWeight.w500),),
          )
        ],
      ),
    );
  }


}

class _MobileNoTextField extends StatelessWidget {
  const _MobileNoTextField({
    required this.data,
    required this.bloc,
    required this.mobileTextEditingController,
  });

  final LoginData data;
  final LoginBloc bloc;
  final TextEditingController mobileTextEditingController;

  @override
  Widget build(BuildContext context) {
    return ContainerBox(
      borderColor: data.isValidMobileNumber == false
          ? AppColors.errorColor
          : null,
      borderRadius: 8,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 6),
            alignment: Alignment.center,
            child: CountryPickerView(
                selectedCountry: data.countryInfo,
                onSelectCountry: (onSelectCountry) {
                  bloc.add(OnSelectedCountryCodeEvent(onSelectCountry));
                },
                isEnable: true),
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.all(15),
            color: AppColors.white,
            width: 1,
            height: 25,
          ),
          Expanded(
            child: AppTextField(
              type: TextFieldType.divider,
              placeHolder: 'Enter your phone number',
              keyboardType: TextInputType.phone,
              isValid: data.isValidMobileNumber,
              onChanged: (s) {
                if (data.isValidMobileNumber != null) {
                  bloc.add(VerifyMobileNumberEvent(s));
                }
              },
              textEditingController: mobileTextEditingController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
