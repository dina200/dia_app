import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

abstract class AuthRepository {
  Future<bool> get isLoggedIn;
  Future<UserType> get userType;
  @mustCallSuper
  Future<void> loginWithGoogleAsPatient() async {
    if (await isLoggedIn) {
      GetIt.I.registerSingleton<UserRepository>(
        GetIt.I<UserRepositoryFactory>().createUserRepository(UserType.Patient),
      );
    }
  }
  @mustCallSuper
  Future<void> loginWithGoogleAsDoctor() async {
    if (await isLoggedIn) {
      GetIt.I.registerSingleton<UserRepository>(
        GetIt.I<UserRepositoryFactory>().createUserRepository(UserType.Doctor),
      );
    }
  }
  @mustCallSuper
  Future<void> logOut() async {
    GetIt.I.unregister<UserRepository>();
  }
}
