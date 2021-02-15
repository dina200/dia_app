import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';

import '../routes.dart' as routes;

part 'widgets/_blood_sugar_storage_form.dart';

class HomePage extends StatelessWidget {
  static const nameRoute = routes.home;

  static PageRoute<HomePage> buildPageRoute() {
    return MaterialPageRoute<HomePage>(
      settings: RouteSettings(name: nameRoute),
      builder: _builder,
    );
  }

  static Widget _builder(BuildContext context) {
    return HomePage();
  }

  @override
  Widget build(BuildContext context) {
    final locale = DiaLocalizations.of(context);

    return GestureDetector(
      onTap: () => _resetFocusNode(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(locale.appName),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: _BloodSugarStorageForm(),
        ),
      ),
    );
  }

  void _resetFocusNode(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
