
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_localization/get_localization.dart';

import 'core/utils/colors.dart';
import 'inject/injector.dart';
import 'localizations/ar.dart';
import 'localizations/en.dart';
import 'main_app.dart';
import 'ui/on_boarding/choose_role_screen.dart';
import 'ui/on_boarding/user_registration_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.transparent
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();

  Localization.localizations.add(EnglishLocalization());
  Localization.localizations.add(ArabicLocalization());

  await Injector.setup();
  runApp(EntryPoint());
}

class EntryPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MainApp(
      initScreen: ChooseRoleScreen(),
    );
  }
}
