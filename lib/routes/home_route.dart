// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:scavengerhunt/misc/palette.dart';
import 'package:scavengerhunt/routes/home_route_navs/compete_nav.dart';
import 'package:scavengerhunt/routes/home_route_navs/explore_nav.dart';
import 'package:scavengerhunt/routes/home_route_navs/home_nav.dart';
import 'package:scavengerhunt/routes/home_route_navs/ranks_nav.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // final FirebaseDatabase _realtimeDatabase = FirebaseDatabase.instance;
  // final _qrBox = Hive.box('qr');
  final User _user = FirebaseAuth.instance.currentUser!;
  late List<Widget> _navPages;
  double _screenWidth = 0;
  double _screenHeight = 0;
  int _currentIndex = 0;

  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _navPages = [
      homeNav(context, _screenWidth, _screenHeight, _user),
      ranksNav(context, _screenWidth, _screenHeight),
      competeNav(context, _screenWidth, _screenHeight),
      exploreNav(context, _screenWidth, _screenHeight),
    ];
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
        body: _navPages.elementAt(_currentIndex),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              gradient: LinearGradient(
                colors: Palette.secondaryGradient,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            height: 90,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: BottomNavigationBar(
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                selectedItemColor: Palette.primaryColor,
                unselectedItemColor: Palette.secondaryBright,
                currentIndex: _currentIndex,
                onTap: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.leaderboard),
                    label: 'Ranks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.gamepad),
                    label: 'Compete',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.explore),
                    label: 'Explore',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
