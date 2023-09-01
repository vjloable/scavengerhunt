// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scavengerhunt/misc/palette.dart';
import 'package:scavengerhunt/routes/scan_route.dart';
import 'package:scavengerhunt/services/authentication_service.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  /// final Stream<QuerySnapshot> _hospitalStream = FirebaseFirestore.instance.collection('user').snapshots();
  final User _user = FirebaseAuth.instance.currentUser!;
  double _screenWidth = 0;
  double _screenHeight = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Palette.bgColor,
      body: SizedBox(
        width: _screenWidth,
        height: _screenHeight,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SafeArea(
                  child: SizedBox(
                    width: _screenWidth,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          iconSize: 40,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(
                            Icons.account_circle,
                            size: 40,
                            color: Palette.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${_user.displayName}',
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
                            Navigator.pop(context);
                            AuthenticationService.signOut();
                          },
                          icon: const Icon(
                            Icons.logout,
                            size: 25,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 100,
                  width: _screenWidth - 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: _screenWidth,
                  height: 80,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Palette.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0).add(
                  const EdgeInsets.only(bottom: 5)
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Hospitals',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Palette.primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 75,
                                    child: Divider(
                                      color: Palette.primaryColor,
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            backgroundColor: Palette.primaryColor,
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BarcodeScannerView(),));
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
