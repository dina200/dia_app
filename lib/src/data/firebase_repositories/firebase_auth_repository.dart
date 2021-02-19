import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:dia_app/src/device/utils/google_service.dart';
import 'package:dia_app/src/device/utils/store_interactor.dart';
import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';

import 'dia_firestore_helper.dart';

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleService _googleService;

  FirebaseAuthRepository()
      : _firebaseAuth = FirebaseAuth.instance,
        _googleService = GetIt.I<GoogleService>();

  @override
  Future<bool> get isLoggedIn async {
    final currentUser = _firebaseAuth.currentUser;
    final token = await StoreInteractor.getToken();
    return currentUser != null && token != null;
  }

  //TODO: only for test - required to remove
  @override
  Future<void> loginWithEmail() async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: 'asd@asd.asd',
        password: 'asdasd',
      );
      await _saveUserData(authResult.user);
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }

  @override
  Future<void> loginWithGoogle() async {
    try {
      final googleAuthentication = await _googleService.getGoogleAuthData();
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );
      final authResult = await _firebaseAuth.signInWithCredential(credential);
      await _saveUserData(authResult.user);
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }

  @override
  Future<void> loginWithApple() {
    // TODO: implement loginWithApple
    throw UnimplementedError();
  }

  @override
  Future<bool> logOut() async {
    await _firebaseAuth.signOut();
    await _googleService.signOut();
    return await StoreInteractor.removeToken();
  }

  Future<void> _saveUserData(User user) async {
    try {
      await StoreInteractor.setToken(user.uid);
      await  DiaFirestoreHelper.saveUserData(
        await StoreInteractor.getToken(),
        user.displayName,
        user.email,
      );
    } catch (e) {
      rethrow;
    }
  }
}
