import 'dart:async';

import 'package:al_quran_app/screens/main_screen.dart';
import 'package:al_quran_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  
  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  
  bool alreadyUsed = false;

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    alreadyUsed = prefs.getBool("alreadyUsed") ?? false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    Timer(Duration(seconds: 3), () => Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (context) { 
      return alreadyUsed ? MainScreen() : OnBoardingScreen();
    })));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold (
        body: Stack(
          children: [
            Center(child: Text('Al Quran App', style: TextStyle(color: Colors.black, fontSize: 30),),),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset('assets/islamic.png'),
            )
          ],
        ),
      ),
    );
  }
  
}