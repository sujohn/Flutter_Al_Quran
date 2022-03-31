import 'dart:js';

import 'package:al_quran_app/constants/constants.dart';
import 'package:al_quran_app/models/quri.dart';
import 'package:al_quran_app/screens/audio_screen.dart';
import 'package:al_quran_app/services/api_services.dart';
import 'package:flutter/material.dart';

import '../models/surah.dart';

class AudioSurahScreen extends StatefulWidget {
  const AudioSurahScreen({ Key? key, required this.quri }) : super(key: key);

  final Quri quri;

  @override
  _AudioSurahScreenState createState() => _AudioSurahScreenState();
}

class _AudioSurahScreenState extends State<AudioSurahScreen> {

  ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Surah List', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        body: FutureBuilder(
          future: _apiServices.getSurah(),
          builder: (context, AsyncSnapshot<List<Surah>> snapshot) {
            if (snapshot.hasData) {
              List<Surah>? surah = snapshot.data;
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => 
                AudioTile(
                  surahName: snapshot.data![index].englishName,
                  totalAya: snapshot.data![index].numberOfAyahs,
                  number: snapshot.data![index].number,
                  onTap: () {
                    
                  }
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

Widget AudioTile({required String? surahName, required totalAya, required number, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
            blurRadius: 5,
            spreadRadius: 0,
            color: Colors.black12,
            offset: Offset(0,3),
          ),
          ]
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 30,
              width: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Text((number).toString(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 28,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(surahName!, textAlign: TextAlign.end,style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 3,),
                Text("Total Aya: $totalAya", style: TextStyle(color: Colors.black54, fontSize: 16),),
              ],
            ),
            Spacer(),
            Icon(Icons.play_circle_fill, color: Constants.kPrimary,),
          ],
        ),
      ),
    ),
  );
}