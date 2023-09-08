import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scavengerhunt/misc/palette.dart';

final _qrBox = Hive.box('qr');
final FirebaseDatabase _realtimeDatabase = FirebaseDatabase.instance;
final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

Widget scannedScreen(BuildContext context, double maxWidth, double maxHeight, User user, String code) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: Palette.secondaryGradient,
        stops: const [0, 1],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: maxHeight,
        width: maxWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _qrBox.get(code) == null ? 'Invalid Code' : 'Code Found!',
              style: TextStyle(
                color: Palette.primaryBright,
                fontSize: 36,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                shadows: [Shadow(color: Palette.primaryDark.withOpacity(0.7), blurRadius: 3, offset: const Offset(1, 1))],
              ),
            ),
            const SizedBox(height: 10),
            Material(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Palette.secondaryDark.withOpacity(0.5),
              elevation: 4,
              child: SizedBox(
                height: 100,
                width: maxWidth - 100,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        code.toString(),
                        style: TextStyle(
                          color: Palette.primaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _realtimeDatabase.goOnline();
                int v = _qrBox.get(code); /// initial value of the QR
                int n = (await _realtimeDatabase.ref("qr_count/$code").get()).value as int; /// number of scans
                await _remoteConfig.fetchAndActivate();
                double m = _remoteConfig.getDouble("multiplier");
                double points = (v * pow(0.97, n)).toDouble() * m;
                print("n: $n");
                print('points = (($v * ${pow(0.97, n)}) * $m)');
                _realtimeDatabase.ref("points").set(
                    {
                      user.uid: ServerValue.increment(points),
                    }
                );
                _realtimeDatabase.ref("qr_count").set(
                    {
                      code: ServerValue.increment(1),
                    }
                );
                await _realtimeDatabase.goOffline();
                Future.delayed(const Duration(milliseconds: 400), () {
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Test'),
            )
          ],
        ),
      ),
    ),
  );
}