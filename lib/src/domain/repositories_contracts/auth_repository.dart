import 'package:dia_app/src/domain/entities/user.dart';

abstract class AuthRepository {
  Future<bool> get isLoggedIn;

  Future<UserRole> get role;

  Future<void> loginWithGoogle();

  Future<void> loginWithGoogleAsDoctor();

  Future<void> logOut();
}
