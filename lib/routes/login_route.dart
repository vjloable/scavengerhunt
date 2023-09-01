import 'package:flutter/material.dart';
import 'package:scavengerhunt/misc/palette.dart';
import 'package:scavengerhunt/services/authentication_service.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailTextInput = TextEditingController();
  final TextEditingController _passwordTextInput = TextEditingController();

  String? _emailErrorText;
  String? _passwordErrorText;
  bool _isPasswordHidden = false;
  double _screenWidth = 0;
  double _screenHeight = 0;

  @override
  void initState() {
    super.initState();
    _isPasswordHidden = true;
    _emailTextInput.text = '';
    _passwordTextInput.text = '';
  }

  Widget _displayLoginWidgetTree() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 600,
            width: 350,
            child: Column(
              children: [
                SizedBox(
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
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _screenWidth <= 250 ? 150 : 370,
                  width: _screenWidth > 360 ? 350 : _screenWidth * 0.85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: _screenWidth <= 250 ? 40 : 60,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.white),
                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(6))
                                ))
                            ),
                            onPressed: () {
                              AuthenticationService.signInWithGoogle();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: _screenWidth <= 250 ? 20 : 30,
                                  width: _screenWidth <= 250 ? 20 : 30,
                                  child: const Image(
                                    image: AssetImage('lib/assets/logo/google_logo.png'),
                                  ),
                                ),
                                _screenWidth > 360 ?
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(
                                        'Sign in with Google',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    :
                                Container(),
                                _screenWidth > 360 ? const SizedBox(width: 30) : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (DragEndDetails details) => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: _screenHeight,
          width: _screenWidth,
          child: _screenHeight > 600
              ? _displayLoginWidgetTree()
              : SingleChildScrollView(child: _displayLoginWidgetTree()),
        ),
      ),
    );
  }
}