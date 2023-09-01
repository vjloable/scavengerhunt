import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scavengerhunt/routes/home_route.dart';
import 'package:scavengerhunt/routes/login_route.dart';
// import 'package:scavengerhunt/routes/redirect_route.dart';

class AuthenticationService{
  static handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData){
            return const HomeRoute();
          } else {
            return const LoginRoute();
          }
        }
    );
  }

  static signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({
        'login_hint': 'user@example.com'
      });
      return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
    } else if (Platform.isAndroid) {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: <String>['email']).signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  static signOut() {
    FirebaseAuth.instance.signOut();
  }
}
