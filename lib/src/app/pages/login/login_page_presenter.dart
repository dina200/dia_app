import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';

class LoginPagePresenter with ChangeNotifier {
  final AuthRepository _authRepository;

  bool _isLoginProcess = false;

  bool get isLoginProcess => _isLoginProcess;

  LoginPagePresenter() : _authRepository = GetIt.I.get<AuthRepository>();

  Future<void> loginWithEmail() async {
    _isLoginProcess = true;
    notifyListeners();

    await _authRepository.loginWithEmail();

    _isLoginProcess = false;
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    _isLoginProcess = true;
    notifyListeners();

    await _authRepository.loginWithGoogle();

    _isLoginProcess = false;
    notifyListeners();
  }

  Future<void> loginWithApple() async {
    _isLoginProcess = true;
    notifyListeners();

    await _authRepository.loginWithApple();

    _isLoginProcess = false;
    notifyListeners();
  }
}
