import 'package:flutter/material.dart';
import 'package:scavengerhunt/misc/palette.dart';
import 'package:scavengerhunt/services/authentication_service.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final TextEditingController _emailTextInput = TextEditingController();
  final TextEditingController _passwordTextInput = TextEditingController();

  double _screenWidth = 0;
  double _screenHeight = 0;

  @override
  void initState() {
    super.initState();
    _emailTextInput.text = '';
    _passwordTextInput.text = '';
  }

  Widget _displayLoginWidgetTree() {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.transparent,
          height: _screenWidth <= 180 ? 100 : 150,
          width: _screenWidth <= 360 ? _screenWidth * 0.85 : 350,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: [
                    Text(
                      'Scavenger',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 45,
                        letterSpacing: 1.2,
                        color: Palette.primaryColor,
                      ),
                    ),
                    const Text(
                      'Hunt!',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          child: Column(
            children: [
              Text(
                'Sign-in options:',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 2,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                width: _screenWidth - 60,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(Colors.white),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(60)),
                        side: BorderSide(color: Palette.primaryColor.withOpacity(0.1)),
                      )),
                    ),
                    onPressed: () {
                      AuthenticationService.signInWithGoogle();
                    },
                    child: const SizedBox(
                      height: 40,
                      width: 40,
                      child: Image(
                        image: AssetImage('lib/assets/logo/google_logo.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Palette.primaryDark,
      body: SizedBox(
        height: _screenHeight,
        width: _screenWidth,
        child: _screenHeight > 600
            ? _displayLoginWidgetTree()
            : SingleChildScrollView(child: _displayLoginWidgetTree()),
      ),
    );
  }
}