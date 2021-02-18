import 'package:flutter/material.dart';

import 'package:dia_app/src/app/routes.dart' as routes;

class RegistrationPage extends StatelessWidget {
  static const nameRoute = routes.registration;

  static PageRoute<RegistrationPage> buildPageRoute() {
    return MaterialPageRoute<RegistrationPage>(
      settings: RouteSettings(name: nameRoute),
      builder: _builder,
    );
  }

  static Widget _builder(BuildContext context) {
    return RegistrationPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
