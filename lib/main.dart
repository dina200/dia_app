import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:get_it/get_it.dart';

import 'src/app/pages/login/login_page.dart';
import 'src/app/pages/main/main_page.dart';
import 'src/data/firebase_repositories/dia_firestore_helper.dart';
import 'src/data/firebase_repositories/firebase_auth_repository.dart';
import 'src/device/utils/google_service.dart';
import 'src/device/utils/store_interactor.dart';
import 'src/domain/repositories_contracts/auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  GetIt.I
    ..registerSingleton<GoogleService>(GoogleService())
    ..registerSingleton<StoreInteractor>(StoreInteractor())
    ..registerSingleton<DiaFirestoreHelper>(DiaFirestoreHelper())
    ..registerSingleton<AuthRepository>(FirebaseAuthRepository());

  final isLoggedIn = await GetIt.I<AuthRepository>().isLoggedIn;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({
    Key key,
    @required this.isLoggedIn,
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
      return MainPage.buildPageRoute();
    }
    return LoginPage.buildPageRoute();
  }
}
