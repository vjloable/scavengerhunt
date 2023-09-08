import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scavengerhunt/misc/palette.dart';
import 'package:scavengerhunt/routes/home_route.dart';

class RedirectRoute extends StatefulWidget {
  const RedirectRoute({super.key});

  @override
  State<RedirectRoute> createState() => _RedirectRouteState();
}

class _RedirectRouteState extends State<RedirectRoute> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseDatabase _realtimeDatabase = FirebaseDatabase.instance;
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final _qrBox = Hive.box('qr');

  void _checkUserAccount() {
    User user = FirebaseAuth.instance.currentUser!;
    var serverTimestamp = FieldValue.serverTimestamp();
    final userDocRef = _firebaseFirestore.collection("user").doc(user.uid);
    final qrColRef = _firebaseFirestore.collection("qr");
    userDocRef.get().then((userId) {
      if (!userId.exists) {
        final userData = {
          "creation": serverTimestamp,
          "email": user.email,
          "uid": user.uid,
          "name": user.displayName,
          "isAdmin": false,
        };
        _firebaseFirestore
            .collection("user")
            .doc(user.uid)
            .set(userData, SetOptions(merge: true));
        _realtimeDatabase.goOnline();
        _realtimeDatabase.ref("points").set(
          {
            user.uid: 0,
          }
        );
        _realtimeDatabase.goOffline();
        qrColRef.get().then((value) {
          for (var element in value.docs) {
            var data = element.data();
            _qrBox.put(element.id, data.values.first);
          }});
      }else{

      }

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeRoute()));
    });
  }

  Future<void> _initRemoteConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 20),
    ));
    await _remoteConfig.setDefaults(const {
      "multiplier": 1,
    });
  }

  @override
  void initState() {
    super.initState();
    _initRemoteConfig();
    Future.delayed(const Duration(seconds: 1), () {
      _checkUserAccount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: Palette.primaryGradient,
          stops: const [0, 0.7, 1],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
      ),
    );
  }
}
