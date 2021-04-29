import 'dart:async';
import 'dart:ui';
import 'package:t_amo/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), (){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_)=> WelcomeScreen(),
          ),
              (route) => false,
      );
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(

        child: Text('TAmo',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),),

      ),

    );
  }
}
