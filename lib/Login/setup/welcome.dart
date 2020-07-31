import 'package:soft_proj/Login/setup/sign_in.dart';
import 'package:soft_proj/Login/setup/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomePage extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.teal[100], end: Colors.yellow[50])
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
      print(controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/l.jpg'),
                    height: 60,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Guest House'],
                  textStyle: TextStyle(
                    fontSize: 33.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundButton(Colors.lightBlueAccent, 'Login', () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }),
            RoundButton(Colors.lightBlueAccent, 'Register', () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistrationScreen()));
            })
          ],
        ),
      ),
    );
  }
}
