import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../blocs/splash_bloc/splash_bloc.dart';
import '../../blocs/splash_bloc/splash_contract.dart';
import '../../core/base_state.dart';
import '../../core/utils/app_font_styles.dart';
import '../../core/utils/approuts.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/images.dart';
import '../../core/view_actions.dart';
import '../../extension/navigation_extensions.dart';
import '../../localizations/base_localization.dart';
import '../on_boarding/choose_role_screen.dart';
import '../on_boarding/login_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends BaseState<SplashBloc, SplashScreen> {
  @override
  void initState() {
    bloc.add(InitEvent());
    super.initState();
  }

  @override
  void onViewEvent(ViewAction event) {
    super.onViewEvent(event);
    if (event is NavigateScreen) {
      if (event.target == AppRoutes.loginScreen) {
        unawaited(
          context.pushAndRemoveUntil(
            settings: const RouteSettings(
              name: AppRoutes.loginScreen,
            ),
            builder: (context) =>  LoginScreen(),
          ),
        );
      }

      if (event.target == AppRoutes.chooseRoleScreen) {
        unawaited(
          context.pushAndRemoveUntil(
            settings: const RouteSettings(
              name: AppRoutes.chooseRoleScreen,
            ),
            builder: (context) => ChooseRoleScreen(),
          ),
        );
      }



    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: Stack(
        children: [

          Positioned(
              top: 120,
              child: Image.asset(AppImages.icSplashBackground)),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 57),
            alignment: Alignment.bottomCenter,

            child: Text(
              BaseLocalization.currentLocalization().splashText,
              style: AppFontTextStyles.textMedium
                  .copyWith(fontSize: 22, color: AppColors.darkTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
