abstract class AuthRepository {
  Future<bool> get isLoggedIn;

  Future<void> loginWithEmail();

  Future<void> loginWithGoogle();

  Future<void> loginWithApple();

  Future<bool> logOut();
}
