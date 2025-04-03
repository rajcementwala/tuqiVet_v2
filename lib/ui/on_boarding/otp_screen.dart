import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import '../../blocs/otp/otp_screen_bloc.dart';
import '../../blocs/otp/otp_screen_contract.dart';
import '../../core/base_state.dart';
import '../../core/screen_state.dart';
import '../../core/utils/app_font_styles.dart';
import '../../core/utils/approuts.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/images.dart';
import '../../core/view_actions.dart';
import '../../extension/navigation_extensions.dart';
import '../../extension/string_extensions.dart';
import '../../localizations/base_localization.dart';
import '../common/action_button.dart';
import 'user_registration_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String code;
  final String userType;

  const OtpScreen({super.key, required this.phoneNumber, required this.code, required this.userType});

  @override
  OtpScreenState createState() => OtpScreenState();
}

class OtpScreenState extends BaseState<OtpBloc, OtpScreen> {
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.add(InitEvent(widget.code,widget.phoneNumber,widget.userType));

  }

  @override
  void onViewEvent(ViewAction event) {
    // TODO: implement onViewEvent
    super.onViewEvent(event);

    if(event is NavigateScreen){
      if(event.target==AppRoutes.userRegistrationScreen){
        unawaited(
          context.push(

            settings: const RouteSettings(
              name: AppRoutes.userRegistrationScreen,
            ),
            builder: (context) =>  const UserRegistrationScreen(),
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
            child: BlocBuilder<OtpBloc, OtpData>(
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
  final OtpData data;
  final OtpBloc bloc;
  final TextEditingController controller;

  const _ChooseRoleBody(
      {required this.data,
      required this.bloc,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: double.infinity,
      height: 48,
      textStyle: AppFontTextStyles.textMedium.copyWith(fontSize: 14,color: AppColors.darkTextColor),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),

        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],

        color: Colors.white,
      ),
    );

    return

      Column(
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                child: SvgPicture.asset(AppSvgImage.icBack),
              )),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                BaseLocalization.currentLocalization().verification,
                style: AppFontTextStyles.textMedium
                    .copyWith(fontSize: 32, color: AppColors.darkTextColor),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                '${BaseLocalization.currentLocalization().otpDescription} \n${data.countryCode} ${data.phoneNumber}',
                maxLines: 3,
                style: AppFontTextStyles.textNormal
                    .copyWith(fontSize: 16, color: AppColors.blackTextColor),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                BaseLocalization.currentLocalization().lblCode,
                style: AppFontTextStyles.textNormal
                    .copyWith(fontSize: 14, color: AppColors.blackTextColor),
              ),
              SizedBox(
                width: double.infinity,
                child: Pinput(
                  length: 6,
                  controller: controller,
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  defaultPinTheme: defaultPinTheme,
                  keyboardType: TextInputType.number,
                  closeKeyboardWhenCompleted: true,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  preFilledWidget: const Text('-'),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.white,
                        width: 2,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    bloc.add(
                      OTPChangedEvent( value),
                    );
                  },
                  onCompleted: (pin) {
                    //sendOTP(context, pin);
                  },
                ),
              ),
              if (data.errorMessage.isNotNullOrEmpty)
                Text(
                  data.errorMessage ?? '',
                  style: AppFontTextStyles.textNormal
                      .copyWith(fontSize: 14, color: AppColors.errorColor),
                ),
              const SizedBox(
                height: 44,
              ),
              Row(
                spacing: 3,
                children: [
                  Text(
                    BaseLocalization.currentLocalization().didNotGetCode,
                    maxLines: 3,
                    style: AppFontTextStyles.textNormal
                        .copyWith(fontSize: 16, color: AppColors.blackTextColor),
                  ),
                  Text(
                    BaseLocalization.currentLocalization().resend,
                    style: AppFontTextStyles.textNormal
                        .copyWith(fontSize: 16, color: AppColors.darkTextColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ActionButton(
                title: BaseLocalization.currentLocalization().verify,
                isEnabled: data.isValidOtp,
                titleTextStyle: AppFontTextStyles.textMedium,
                onTap: () {
                  bloc.add(VerifyOtpEvent(controller.text));
                },
              )
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
