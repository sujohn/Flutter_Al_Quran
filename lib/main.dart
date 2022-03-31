

import 'package:al_quran_app/constants/constants.dart';
import 'package:al_quran_app/screens/juz_screen.dart';
import 'package:al_quran_app/screens/splash_screen.dart';
import 'package:al_quran_app/screens/surah_detail_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al Quran Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins'
      ),
      home: SplashScreen(),
      routes: {
        JuzScreen.id:(context) => JuzScreen(),
        SurahDetailScreen.id:(context) => SurahDetailScreen(),
      },
    );
  }
}

