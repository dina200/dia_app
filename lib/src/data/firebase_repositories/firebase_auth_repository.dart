import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get_it/get_it.dart';

import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/device/utils/google_service.dart';
import 'package:dia_app/src/device/utils/store_interactor.dart';
import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';

import 'dia_firestore_helper.dart';

class FirebaseAuthRepository extends AuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final GoogleService _googleService;
  final StoreInteractor _storeInteractor;

  FirebaseAuthRepository()
      : _firebaseAuth =  auth.FirebaseAuth.instance,
        _googleService = GetIt.I<GoogleService>(),
        _storeInteractor = GetIt.I<StoreInteractor>();

  @override
  Future<bool> get isLoggedIn async {
    final currentUser = _firebaseAuth.currentUser;
    final token = await _storeInteractor.getToken();
    return currentUser != null && token != null;
  }

  @override
  Future<UserRole> get role async {
    if (await isLoggedIn) {
      return await _storeInteractor.getRole();
    }
    return null;
  }

  @override
  Future<void> loginWithGoogle() async {
    final googleAuthentication = await _googleService.getGoogleAuthData();
    final credential =  auth.GoogleAuthProvider.credential(
      idToken: googleAuthentication.idToken,
      accessToken: googleAuthentication.accessToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    await _savePatientData(authResult.user);
  }


  @override
  Future<void> loginWithGoogleAsDoctor() async {
    final googleAuthentication = await _googleService.getGoogleAuthData();
    final credential =  auth.GoogleAuthProvider.credential(
      idToken: googleAuthentication.idToken,
      accessToken: googleAuthentication.accessToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    await _saveDoctorData(authResult.user);
  }

  @override
  Future<void> logOut() async {
    await _googleService.signOut();
    await _storeInteractor.removeRole();
    await _storeInteractor.removeToken();
  }

  Future<void> _savePatientData(auth.User user) async {
    await _storeInteractor.setToken(user.uid);
    await _storeInteractor.setRole(UserRole.Patient);
    await DiaFirestoreHelper.savePatientData(
      await _storeInteractor.getToken(),
      user.displayName,
      user.email,
    );
  }

  Future<void> _saveDoctorData(auth.User user) async {
    await _storeInteractor.setToken(user.uid);
    await _storeInteractor.setRole(UserRole.Doctor);
    await DiaFirestoreHelper.saveDoctorData(
      await _storeInteractor.getToken(),
      user.displayName,
      user.email,
    );
  }
}
