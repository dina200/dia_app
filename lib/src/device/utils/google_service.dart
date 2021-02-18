import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:dia_app/src/domain/entities/exceptions.dart';

class GoogleService {
  final _googleSignIn = GoogleSignIn(scopes: <String>['email']);

  Future<GoogleSignInAuthentication> getGoogleAuthData() async {
    final account = await _googleSignIn.signIn();
    final isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      try {
        return await account.authentication;
      } finally {
        await _googleSignIn.disconnect();
      }
    }
    throw GoogleLoginException();
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
