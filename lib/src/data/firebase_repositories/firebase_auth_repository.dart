import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get_it/get_it.dart';

import 'package:dia_app/src/data/firebase_repositories/dia_firestore_helper.dart';
import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/device/utils/google_service.dart';
import 'package:dia_app/src/device/utils/store_interactor.dart';
import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';

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
  Future<UserType> get userType async {
    if (await isLoggedIn) {
      return await _storeInteractor.getUserType();
    }
    return null;
  }

  @override
  Future<void> loginWithGoogleAsPatient() async {
    final googleAuthentication = await _googleService.getGoogleAuthData();
    final credential =  auth.GoogleAuthProvider.credential(
      idToken: googleAuthentication.idToken,
      accessToken: googleAuthentication.accessToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    await _savePatientData(authResult.user);
    super.loginWithGoogleAsPatient();
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
    super.loginWithGoogleAsDoctor();
  }

  @override
  Future<void> logOut() async {
    await _googleService.signOut();
    await _storeInteractor.removeType();
    await _storeInteractor.removeToken();
    super.logOut();
  }

  Future<void> _savePatientData(auth.User user) async {
    await _storeInteractor.setToken(user.uid);
    await _storeInteractor.setUserType(UserType.Patient);
    await DiaFirestoreHelper.savePatientData(
      await _storeInteractor.getToken(),
      user.displayName,
      user.email,
    );
  }

  Future<void> _saveDoctorData(auth.User user) async {
    await _storeInteractor.setToken(user.uid);
    await _storeInteractor.setUserType(UserType.Doctor);
    await DiaFirestoreHelper.saveDoctorData(
      await _storeInteractor.getToken(),
      user.displayName,
      user.email,
    );
  }
}
