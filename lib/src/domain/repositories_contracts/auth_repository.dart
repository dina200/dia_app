abstract class AuthRepository {
  Future<bool> get isLoggedIn;

  Future<void> loginWithGoogle();

  Future<void> loginWithGoogleAsDoctor();

  Future<bool> logOut();
}
