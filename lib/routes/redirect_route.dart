import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../misc/palette.dart';

class RedirectRoute extends StatefulWidget {
  const RedirectRoute({super.key});

  @override
  State<RedirectRoute> createState() => _RedirectRouteState();
}

class _RedirectRouteState extends State<RedirectRoute> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  /*
  void _checkUserAccount() {
    User user = FirebaseAuth.instance.currentUser!;
    var serverTimestamp = FieldValue.serverTimestamp();
    final userDocRef = _firebaseFirestore.collection("user").doc(user.uid);
    userDocRef.get().then((userId) {
      if (!userId.exists) {
        final userData = {
          "user_id": user.uid,
          "active": true,
          "locked": false,
          "last_successful_login": serverTimestamp,
          "failed_login_attempt": 0,
          "created_by": user.uid,
          "created_date": serverTimestamp,
          "updated_by": user.uid,
          "updated_date": serverTimestamp,
          "email": user.email,
        };
        _firebaseFirestore
            .collection("user")
            .doc(user.uid)
            .set(userData, SetOptions(merge: true));
      } else {
        final userData = {
          "last_successful_login": serverTimestamp,
          "updated_by": user.uid,
          "updated_date": serverTimestamp,
        };
        _firebaseFirestore
            .collection("user")
            .doc(user.uid)
            .set(userData, SetOptions(merge: true));
      }
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeRoute()));
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeTest())); ///Testing
    });
  }*/

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      // _checkUserAccount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            color: Palette.primaryColor,
            value: null,
          ),
        ),
      ),
    );
  }
}
