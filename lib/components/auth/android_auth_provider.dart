import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_provider_base.dart';

class _AndroidAuthProvider implements AuthProviderBase {
  @override
  Future<FirebaseApp> initialize() async {
    return await Firebase.initializeApp(
      name: 'ViVid',
      options: FirebaseOptions(
        apiKey: "AIzaSyCKD4t8aRVaFsqhrOmHf2mt3E1Lsfa7BBM",
        authDomain: "vivid-7c650.firebaseapp.com",
        projectId: "vivid-7c650",
        storageBucket: "vivid-7c650.appspot.com",
        messagingSenderId: "756528492864",
        appId: "1:756528492864:web:d0021a11840e48744acaa5"
      ),
    );
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}

class AuthProvider extends _AndroidAuthProvider {}