import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';

class LoginPagePresenter with ChangeNotifier {
  final AuthRepository _authRepository;

  bool _isLoginProcess = false;

  bool get isLoginProcess => _isLoginProcess;

  LoginPagePresenter() : _authRepository = GetIt.I.get<AuthRepository>();

  Future<void> loginWithEmail() async {
    await _login(_authRepository.loginWithEmail);
  }

  Future<void> loginWithGoogle() async {
    await _login(_authRepository.loginWithGoogle);
  }

  Future<void> loginWithApple() async {
    await _login(_authRepository.loginWithApple);
  }

  Future<void> _login(Function login) async {
    _isLoginProcess = true;
    notifyListeners();
    try {
      await login();
    } catch (e) {
      rethrow;
    } finally {
      _isLoginProcess = false;
      notifyListeners();
    }
  }
}
