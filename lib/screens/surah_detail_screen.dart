

import 'package:al_quran_app/constants/constants.dart';
import 'package:al_quran_app/services/api_services.dart';
import 'package:al_quran_app/widgets/surah_translation_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../models/surah_translation.dart';

enum Translation { English, Bengali}

class SurahDetailScreen extends StatefulWidget {
  //const SurahDetailScreen({ Key? key }) : super(key: key);

  static const String id = 'surahDetailScreen';

  @override
  _SurahDetailScreenState createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {

  ApiServices apiservices = ApiServices();
  SolidController _controller = SolidController();
  Translation? _translation  = Translation.English;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) => {
      setState(() {
        String? lan = prefs.getString("translation_lan");
        _translation = Translation.values.firstWhere((e) => e.toString() == lan);
        print('lan ${_translation.toString()}');
      })
      });
  }
  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    String? lan = prefs.getString("translation_lan");
    _translation = Translation.values.firstWhere((e) => e.toString() == lan);
    print('lan ${_translation.toString()}');
  }

  void setData(String lan) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("translation_lan", lan);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: FutureBuilder(
        future: apiservices.getTranslation(Constants.surahIndex!, _translation!.index),
        builder: (context, AsyncSnapshot<SurahTranslationList> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.translationList.length,
              itemBuilder: (context, index) => SurahTranslationTile(surahTranslation: snapshot.data!.translationList[index], index: index));
          } else {
            return Center(child: Text("Translation not found"));
          }
        }
      ),
      bottomSheet: SolidBottomSheet(
        headerBar: Container(
          color: Theme.of(context).primaryColor,
          height: 50,
          child: Center(
            child: Text("Swipe me!", style: TextStyle(color: Colors.white),),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: 30,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('English'),
                    leading: Radio<Translation>(
                      value: Translation.English,
                      groupValue: _translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          _translation = value;
                          setData(value.toString());
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Bengali'),
                    leading: Radio<Translation>(
                      value: Translation.Bengali,
                      groupValue: _translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          _translation = value;
                          setData(value.toString());
                        });
                      },
                    ),
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