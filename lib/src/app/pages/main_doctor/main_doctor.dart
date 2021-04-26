import 'package:dia_app/src/app/pages/main_doctor/tabs/patients/patients_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:provider/provider.dart';

import 'package:dia_app/src/app/pages/login/login_page.dart';
import 'package:dia_app/src/app/widgets/loading_layout.dart';
import 'package:dia_app/src/app/pages/main_doctor/tabs/doctor/doctor_tab.dart';
import 'package:dia_app/src/app/pages/main_doctor/main_doctor_presenter.dart';
import 'package:dia_app/src/app/routes.dart' as routes;

class MainDoctorPage extends StatefulWidget {
  static const nameRoute = routes.mainDoctor;

  static PageRoute<MainDoctorPage> buildPageRoute() {
    return MaterialPageRoute<MainDoctorPage>(
      settings: RouteSettings(name: nameRoute),
      builder: _builder,
    );
  }

  static Widget _builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MainDoctorPagePresenter(),
        child: MainDoctorPage());
  }

  @override
  _MainDoctorPageState createState() => _MainDoctorPageState();
}

class _MainDoctorPageState extends State<MainDoctorPage> {
  int _selectedIndex = 1;

  DiaLocalizations get _locale => DiaLocalizations.of(context);
  MainDoctorPagePresenter get _watch => context.watch<MainDoctorPagePresenter>();
  MainDoctorPagePresenter get _read => context.read<MainDoctorPagePresenter>();

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
                label: _locale.doctor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_outlined),
                label: _locale.patients,
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
      case 0: return DoctorTab();
      case 1: return PatientsTab();
      default: return Container();
    }
  }

  Widget _buildFloatActionButton() {
    switch (_selectedIndex) {
      case 1:
        return FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        );
      default: return null;
    }
  }
}
