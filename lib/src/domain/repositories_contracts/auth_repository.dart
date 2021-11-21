import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';

abstract class AuthRepository {
  Future<bool> get isLoggedIn;

  Future<UserType> get userType;

  Future<UserType> init() async {
    if (await isLoggedIn) {
      final type = await userType;
      _registerUserRepository(type);
      return type;
    }
    return null;
  }

  @mustCallSuper
  Future<void> loginWithGoogleAsPatient() async {
    if (await isLoggedIn) {
      _registerUserRepository(UserType.Patient);
    }
  }

  @mustCallSuper
  Future<void> loginWithGoogleAsDoctor() async {
    if (await isLoggedIn) {
      _registerUserRepository(UserType.Doctor);
    }
  }

  @mustCallSuper
  Future<void> logOut() async {
    GetIt.I.unregister<UserRepository>();
  }

  void _registerUserRepository(UserType userType) {
    GetIt.I.registerSingleton<UserRepository>(
      GetIt.I<UserRepositoryFactory>().createUserRepository(userType),
    );
  }
}
