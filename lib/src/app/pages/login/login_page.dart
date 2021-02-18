import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';

import 'package:dia_app/src/app/routes.dart' as routes;

part 'widgets/_login_buttons.dart';

class LoginPage extends StatelessWidget {
  static const nameRoute = routes.login;

  static PageRoute<LoginPage> buildPageRoute() {
    return MaterialPageRoute<LoginPage>(
      settings: RouteSettings(name: nameRoute),
      builder: _builder,
    );
  }

  static Widget _builder(BuildContext context) {
    return LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(child: _buildTitle()),
          Expanded(child: _LoginButtons()),
          Expanded(child: SizedBox())
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final locale = DiaLocalizations.of(context);

        return Align(
          alignment: Alignment.bottomCenter,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: locale.appName,
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 24.0,
                  ),
                ),
                TextSpan(text: '\n'),
                TextSpan(
                  text: locale.tagline,
                  style: theme.textTheme.bodyText2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
