import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../blocs/choose_role/choose_role_bloc.dart';
import '../../blocs/choose_role/choose_role_contract.dart';
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
import '../../localizations/base_localization.dart';
import '../common/action_button.dart';
import '../on_boarding/login_screen.dart';

class ChooseRoleScreen extends StatefulWidget {
  ChooseRoleScreen({super.key});

  @override
  ChooseRoleScreenState createState() {
    return ChooseRoleScreenState();
  }
}

class ChooseRoleScreenState
    extends BaseState<ChooseRoleBloc, ChooseRoleScreen> {
  @override
  void initState() {
    super.initState();
    bloc.add(InitEvent());
  }

  @override
  void onViewEvent(ViewAction event) {
    super.onViewEvent(event);
    if (event is NavigateScreen) {

      unawaited(
        context.push(
          settings: const RouteSettings(
            name: AppRoutes.loginScreen,
          ),
          builder: (context) =>   LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: SafeArea(
          child: BlocProvider.value(
            value: bloc,
            child: BlocBuilder<ChooseRoleBloc, ChooseRoleData>(
              builder: (context, data) {
                switch (data.state) {
                  case ScreenState.empty:
                  case ScreenState.loading:
                  case ScreenState.content:
                    return _ChooseRoleBody(
                      bloc: bloc,
                      data: data,
                    );
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
  final ChooseRoleBloc bloc;
  final ChooseRoleData data;

  const _ChooseRoleBody({required this.bloc, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                BaseLocalization.currentLocalization().whoAreYou,
                style: AppFontTextStyles.textMedium
                    .copyWith(fontSize: 32, color: AppColors.darkTextColor),
              ),
              Text(
                BaseLocalization.currentLocalization().chooseRoleToStart,
                style: AppFontTextStyles.textNormal
                    .copyWith(fontSize: 16, color: AppColors.blackTextColor),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: (){
                  bloc.add(OnRoleSelectionEvent(UserType.serviceProvider));
                },
                splashColor: AppColors.transparent,
                highlightColor: AppColors.transparent,
                child: ContainerBox(
                  borderRadius: 18,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 16, right: 14),
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          spacing: 4,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              BaseLocalization.currentLocalization()
                                  .serviceProvider,
                              style: AppFontTextStyles.textMedium
                                  .copyWith(
                                      fontSize: 24,
                                      color: AppColors.blackTextColor),
                            ),
                            Text(
                              BaseLocalization.currentLocalization()
                                  .serviceProviderDesc,
                              maxLines: 3,
                              style: AppFontTextStyles.textNormal
                                  .copyWith(
                                      fontSize: 14,
                                      color: AppColors.blackTextColor
                                          .withAlpha(70)),
                            ),
                          ],
                        )),
                        SvgPicture.asset(data.userType == UserType.serviceProvider
                            ? AppSvgImage.icRadioChecked
                            : AppSvgImage.icRadioUnChecked)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: (){
                  bloc.add(OnRoleSelectionEvent(UserType.animalOwner));
                },
                splashColor: AppColors.transparent,
                highlightColor: AppColors.transparent,
                child: ContainerBox(
                  borderRadius: 18,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 16, right: 14),
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          spacing: 4,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              BaseLocalization.currentLocalization()
                                  .animalOwner,
                              style: AppFontTextStyles.textMedium
                                  .copyWith(
                                      fontSize: 24,
                                      color: AppColors.blackTextColor),
                            ),
                            Text(
                              BaseLocalization.currentLocalization()
                                  .animalOwnerDesc,
                              maxLines: 3,
                              style: AppFontTextStyles.textNormal
                                  .copyWith(
                                      fontSize: 14,
                                      color: AppColors.blackTextColor
                                          .withAlpha(70)),
                            ),
                          ],
                        )),
                        SvgPicture.asset(data.userType == UserType.animalOwner
                            ? AppSvgImage.icRadioChecked
                            : AppSvgImage.icRadioUnChecked)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

                ActionButton(title: BaseLocalization
                    .currentLocalization()
                    .lblContinue,isEnabled: data.userType!=null,titleTextStyle:AppFontTextStyles.textMedium,
                  onTap: (){
                      bloc.add(RedirectToLoginScreenEvent());
                  },
                )

            ]),
      ),
    );
  }
}
