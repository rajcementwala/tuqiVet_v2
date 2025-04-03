import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'blocs/main_app/main_app_bloc.dart';
import 'blocs/main_app/main_app_contract.dart';
import 'core/base_state.dart';
import 'core/constants.dart';
import 'localizations/ar.dart';
import 'localizations/en.dart';

class MainApp extends StatefulWidget {
  const MainApp({required this.initScreen, super.key});

  final Widget initScreen;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends BaseState<MainAppBloc, MainApp> {
  @override
  void initState() {
    bloc.add(InitEvent());
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider<MainAppBloc>(
      create: (BuildContext context) => bloc,
      child: BlocBuilder<MainAppBloc, MainAppData>(
        builder: (BuildContext context, MainAppData data) {
          print(data.local);

          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: data.appThemeData,
            home: widget.initScreen,


            supportedLocales: [ArabicLocalization().toLocale(),EnglishLocalization().toLocale()],
            locale: data.local,
            localizationsDelegates: [
              // Here !
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],


          );
        },
      ),
    );
  }
}
