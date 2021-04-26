import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:provider/provider.dart';

import 'package:dia_app/src/app/routes.dart' as routes;

import 'package:dia_app/src/app/pages/login/login_page.dart';
import 'package:dia_app/src/app/widgets/loading_layout.dart';

import 'main_page_presenter.dart';
import 'tabs/diagnostics/diagnostics_tab.dart';
import 'tabs/statistics/statistics_tab.dart';
import 'tabs/patient/patient_tab.dart';

class MainPage extends StatefulWidget {
  static const nameRoute = routes.main;

  static PageRoute buildPageRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: nameRoute),
      builder: _builder,
    );
  }

  static Widget _builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainPagePresenter(context),
      child: MainPage(),
    );
  }

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  DiaLocalizations get _locale => DiaLocalizations.of(context);
  MainPagePresenter get _watch => context.watch<MainPagePresenter>();
  MainPagePresenter get _read => context.read<MainPagePresenter>();

  @override
  Widget build(BuildContext context) {
    return LoadingLayout(
      isLoading: _watch.isLogOutLoading,
      child: GestureDetector(
        onTap: _resetFocusNode,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_locale.appName),
            actions: [_buildAppBarAction()],
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
          floatingActionButton: _buildFloatActionButton(),
        ),
      ),
    );
  }

  void _resetFocusNode() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Widget _buildAppBarAction() {
    switch (_selectedIndex) {
      case 0:
        return IconButton(
          icon: Icon(Icons.exit_to_app),
          tooltip: _locale.changeUser,
          onPressed: _logOut,
        );
      default: return Container();
    }
  }

  Future<void> _logOut() async {
    await _read.logOut();
    await Navigator.of(context).pushAndRemoveUntil(
      LoginPage.buildPageRoute(),
      (route) => false,
    );
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _tabBuilder() {
    switch (_selectedIndex) {
      case 0: return PatientTab();
      case 1: return DiagnosticsTab();
      case 2: return StatisticsTab();
      default: return Container();
    }
  }

  Widget _buildFloatActionButton() {
    switch (_selectedIndex) {
      case 2:
        return FloatingActionButton.extended(
          label: Text(_locale.sendDataToDoc),
          onPressed: _watch.isStatisticNotEmpty ? _sendStatistic : null,
        );
      default: return null;
    }
  }

  Future<void> _sendStatistic() async {
    await _read.sendStatistic();
  }
}
