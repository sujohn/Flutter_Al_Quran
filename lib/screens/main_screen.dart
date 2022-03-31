import 'package:al_quran_app/constants/constants.dart';
import 'package:al_quran_app/screens/audio_screen.dart';
import 'package:al_quran_app/screens/home_screen.dart';
import 'package:al_quran_app/screens/prayer_screen.dart';
import 'package:al_quran_app/screens/quran_screen.dart';
import 'package:al_quran_app/screens/quri_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  int selectedIndex = 0;
  List<Widget> _widgetList = [HomeScreen(), QuranScreen(), QuriListScreen(), PrayerScreen()];
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: 
        Scaffold(
          body: _widgetList[selectedIndex],
          bottomNavigationBar: ConvexAppBar(
            items: [
              TabItem(icon: Image.asset('assets/home.png', color: Colors.white,), title: 'Home'),
              TabItem(icon: Image.asset('assets/holyQuran.png', color: Colors.white), title: 'Quran'),
              TabItem(icon: Image.asset('assets/audio.png', color: Colors.white), title: 'Quri'),
              TabItem(icon: Image.asset('assets/mosque.png', color: Colors.white), title: 'Prayer'),
            ],
            initialActiveIndex: 0,//optional, default as 0
            onTap: updateIndex,
            backgroundColor: Constants.kPrimary,
            activeColor: Constants.kPrimary,
          )
        ),
    );
  }

  void updateIndex(index) {
    setState(() {
      selectedIndex = index;
    });
  }
}