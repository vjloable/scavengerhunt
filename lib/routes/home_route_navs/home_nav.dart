import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scavengerhunt/misc/palette.dart';
import 'package:scavengerhunt/routes/scan_route.dart';
import 'package:scavengerhunt/services/authentication_service.dart';

final FirebaseDatabase _realtimeDatabase = FirebaseDatabase.instance;

Future<DataSnapshot> _getPoints(User user) async {
  await _realtimeDatabase.goOnline();
  return _realtimeDatabase.ref("points/${user.uid}").get();
}

Widget homeNav(BuildContext context, double maxWidth, double maxHeight, User user) {
  return SizedBox(
    width: maxWidth,
    height: maxHeight,
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SafeArea(
              child: SizedBox(
                width: maxWidth,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      iconSize: 40,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.account_circle,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${user.displayName}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      iconSize: 25,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.of(context).pop();
                        AuthenticationService.signOut();
                      },
                      icon: Icon(
                        Icons.logout,
                        size: 25,
                        color: Palette.primaryAccentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 100),
          SizedBox(
            height: 160,
            width: maxWidth - 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: _getPoints(user),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      double points = double.parse(snapshot.data!.value.toString());
                      _realtimeDatabase.goOffline();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*Container(
                            color: Colors.transparent,
                            width: 40,
                            height: 40,
                            child: Stack(
                              alignment: Alignment.center,
                              fit: StackFit.expand,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: CircleAvatar(
                                      radius: 40,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: RadialGradient(
                                            colors: [
                                              Palette.primaryColor.withOpacity(0.3),
                                              Palette.primaryBright.withOpacity(0.3),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 32,
                                    width: 32,
                                    child: CircleAvatar(
                                      radius: 32,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Palette.secondaryBright,
                                              Palette.secondaryColor,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),*/
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: SizedBox(
                                height: 70,
                                child: Center(
                                  child: Text(
                                    points.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 55,
                                      fontWeight: FontWeight.w600,
                                      color: Palette.primaryBright,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }else{
                      return SizedBox(
                        height: 70,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Palette.primaryColor,
                            backgroundColor: Palette.secondaryBright,
                          ),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Scavenged Points',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      color: Palette.primaryBright,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.transparent,
            height: 110,
            width: maxWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 10,
                      shape: const CircleBorder(),
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            colors: [Palette.secondaryDark, Palette.primaryColor],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BarcodeScannerView(user: user)));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: const CircleBorder(),
                            fixedSize: const Size(65, 65),
                            alignment: Alignment.center,
                            padding: EdgeInsets.zero,
                          ),
                          child: const Icon(Icons.qr_code_2, size: 30, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text('Scan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 10,
                      shape: const CircleBorder(),
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            colors: [Palette.secondaryDark, Palette.primaryColor],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: const CircleBorder(),
                            fixedSize: const Size(65, 65),
                            alignment: Alignment.center,
                            padding: EdgeInsets.zero,
                          ),
                          child: const Icon(Icons.redeem, size: 30, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text('Redeem',  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).add(const EdgeInsets.only(bottom: 5)),
            child: SizedBox(
              height: 60,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scan History',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w100,
                          color: Palette.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: maxWidth - 100,
                        child: Divider(
                          color: Palette.primaryColor,
                          thickness: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}