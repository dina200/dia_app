import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';

import 'src/app/pages/auth/login/login_page.dart';
import 'src/app/pages/main/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateTitle: _onGenerateTitle,
      onGenerateRoute: _onGenerateRoute,
      localizationsDelegates: DiaLocalizations.localizationsDelegates,
      supportedLocales: DiaLocalizations.supportedLocales,
    );
  }

  String _onGenerateTitle(BuildContext context) {
    return DiaLocalizations.of(context).appName;
  }

  Route _onGenerateRoute(RouteSettings settings) {
    return LoginPage.buildPageRoute();
  }
}
