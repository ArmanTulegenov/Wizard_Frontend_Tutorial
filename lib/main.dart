import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/loading.dart';
import 'package:flutter_app/pages/registration.dart';
import 'package:flutter_app/pages/confirmation.dart';

import 'app_localizations.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      primarySwatch: Colors.amber,
      // This makes the visual density adapt to the platform that you run
      // the app on. For desktop platforms, the controls will be smaller and
      // closer together (more dense) than on mobile platforms.
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    supportedLocales: [
      Locale('en', 'US'),
      Locale('ru', 'RU'),
      Locale('tr', 'TR')
    ],
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    localeResolutionCallback: (locale, supportedLocales) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode &&
            supportedLocale.countryCode == locale.countryCode) {
          return supportedLocale;
        }
      }
      return supportedLocales.first;
    },
    // home: MyHomePage(title: 'Flutter Demo Home Page'),
    // initialRoute: '/home',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
      '/registration': (context) => RegistrationPage(title: 'Flutter Demo Home Page'),
      '/confirmation': (context) => ConfirmationPage(title: 'Flutter Demo Home Page'),
    },
  ));
}

