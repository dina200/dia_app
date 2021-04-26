import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:get_it/get_it.dart';

import 'src/app/pages/login/login_page.dart';
import 'src/app/pages/main/main_page.dart';
import 'src/app/pages/main_doctor/main_doctor.dart';
import 'src/data/firebase_repositories/firebase_auth_repository.dart';
import 'src/data/firebase_repositories/firebase_user_repository.dart';
import 'src/device/utils/google_service.dart';
import 'src/domain/repositories_contracts/auth_repository.dart';
import 'src/domain/repositories_contracts/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  GetIt.I
    ..registerSingleton<GoogleService>(GoogleService())
    ..registerSingleton<AuthRepository>(FirebaseAuthRepository())
    ..registerSingleton<UserRepository>(FirebaseUserRepository());

  final isLoggedIn = await GetIt.I<AuthRepository>().isLoggedIn;
  final role = await GetIt.I<AuthRepository>().role;
  runApp(MyApp(isLoggedIn: isLoggedIn, role: role));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final int role;

  const MyApp({
    Key key,
    @required this.isLoggedIn,
    @required this.role,
  })  : assert(isLoggedIn != null),
        super(key: key);

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
    if (isLoggedIn) {
      switch(role) {
        case 0: return MainPage.buildPageRoute();
        case 1: return MainDoctorPage.buildPageRoute();
      }
    }
    return LoginPage.buildPageRoute();
  }
}
