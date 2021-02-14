import 'package:flutter/material.dart';

import '../routes.dart' as routes;

class HomePage extends StatelessWidget {
  static const nameRoute = routes.home;

  static PageRoute<HomePage> buildPageRoute() {
    return MaterialPageRoute<HomePage>(
      builder: _builder,
      settings: RouteSettings(name: nameRoute),
    );
  }

  static Widget _builder(BuildContext context) {
    return HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(),
    );
  }
}
