import 'package:dia_app/src/device/utils/store_interactor.dart';
import 'package:dia_app/src/domain/entities/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:get_it/get_it.dart';

import 'src/app/pages/login/login_page.dart';
import 'src/app/pages/main/main_page.dart';
import 'src/app/pages/main_doctor/main_doctor_page.dart';
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
    ..registerSingleton<StoreInteractor>(StoreInteractor())
    ..registerSingleton<AuthRepository>(FirebaseAuthRepository())
    ..registerSingleton<UserRepositoryFactory>(FirebaseUserRepositoryFactory());

  final userType = await GetIt.I<AuthRepository>().init();
  runApp(MyApp(userType: userType));
}

class MyApp extends StatelessWidget {
  final UserType userType;

  const MyApp({
    Key key,
    @required this.userType,
  }) : super(key: key);

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
    if (userType != null) {
      switch(userType) {
        case UserType.Patient: return MainPage.buildPageRoute();
        case UserType.Doctor: return MainDoctorPage.buildPageRoute();
      }
    }
    return LoginPage.buildPageRoute();
  }
}
