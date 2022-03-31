
import 'package:al_quran_app/constants/constants.dart';
import 'package:al_quran_app/models/sajda.dart';
import 'package:al_quran_app/models/surah.dart';
import 'package:al_quran_app/screens/juz_screen.dart';
import 'package:al_quran_app/screens/surah_detail_screen.dart';
import 'package:al_quran_app/services/api_services.dart';
import 'package:al_quran_app/widgets/surah_custom_list_tile.dart';
import 'package:flutter/material.dart';

import '../widgets/sajda_custom_list_tile.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({ Key? key }) : super(key: key);

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {

  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Quran"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Text("Surah", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),),
              Text("Sajda", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),),
              Text("Juz", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FutureBuilder(
              future: apiServices.getSurah(),
              builder: (BuildContext context, AsyncSnapshot<List<Surah>> snapshot) {
                if (snapshot.hasData) {
                  List<Surah>? surah = snapshot.data;
                  return ListView.builder(
                    itemCount: surah!.length,
                    itemBuilder: (context, index) => SurahCustomListTile(surah: surah[index], context: context, ontap: (){
                      setState(() {
                        Constants.surahIndex = (index + 1);
                      });
                      Navigator.pushNamed(context, SurahDetailScreen.id);
                    }),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            FutureBuilder(
              future: apiServices.getSajda(),
              builder: (BuildContext context, AsyncSnapshot<List<Sajda>> snapshot) {
                if (snapshot.hasData) {
                  List<Sajda>? sajda = snapshot.data;
                  return ListView.builder(
                    itemCount: sajda!.length,
                    itemBuilder: (context, index) => SajdaCustomListTile(sajda: sajda[index], context: context, ontap: (){
                      
                    }),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          Constants.juzIndex = (index + 1);
                        });
                        Navigator.pushNamed(context, JuzScreen.id);
                      },
                      child: Card(
                        elevation: 4,
                        color: Colors.blueGrey,
                        child: Center(
                          child: Text('${index+1} ', style: TextStyle(color: Colors.white, fontSize: 20),),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}