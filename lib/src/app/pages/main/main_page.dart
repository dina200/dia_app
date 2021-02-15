import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';

import 'package:dia_app/src/app/routes.dart' as routes;

import 'tabs/diagnostics/diagnostics_tab.dart';
import 'tabs/statistics/statistics_tab.dart';
import 'tabs/user/user_tab.dart';

class MainPage extends StatefulWidget {
  static const nameRoute = routes.main;

  static PageRoute<MainPage> buildPageRoute() {
    return MaterialPageRoute<MainPage>(
      settings: RouteSettings(name: nameRoute),
      builder: _builder,
    );
  }

  static Widget _builder(BuildContext context) {
    return MainPage();
  }

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  DiaLocalizations get _locale => DiaLocalizations.of(context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _resetFocusNode,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_locale.appName),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: _locale.user,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: _locale.diagnostics,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: _locale.statistics,
            ),
          ],
        ),
        body: _tabBuilder(),
      ),
    );
  }

  void _resetFocusNode() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Widget _tabBuilder() {
    switch (_selectedIndex) {
      case 0: return UserTab();
      case 1: return DiagnosticsTab();
      case 2: return StatisticsTab();
      default: return Container();
    }
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }
}
