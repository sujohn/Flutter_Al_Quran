
import 'dart:convert';
import 'dart:math';

import 'package:al_quran_app/models/aya_of_the_day.dart';
import 'package:al_quran_app/models/juz.dart';
import 'package:al_quran_app/models/quri.dart';
import 'package:al_quran_app/models/sajda.dart';
import 'package:al_quran_app/models/surah.dart';
import 'package:al_quran_app/models/surah_translation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiServices {

  final endPointUrl = "http://api.alquran.cloud/v1/surah";
  List<Surah> list = [];

  Future<AyaOfTheDay> getAyaOfTheDay() async {

    String url = "http://api.alquran.cloud/v1/ayah/${random(1, 6237)}/editions/quran-uthmani,en.asad,en.pickthall";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return AyaOfTheDay.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed to load post");
    }
  }

  random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  Future<List<Surah>> getSurah() async {
    Response response = await http.get(Uri.parse(endPointUrl));
    if (response.statusCode == 200) {
      Map<String,dynamic> json = jsonDecode(response.body);
      json['data'].forEach((element){
        if (list.length < 114) {
          list.add(Surah.fromJson(element));
        }
      });
      print('ol ${list.length}');
      return list;
    } else {
      throw ("Can't get the Surah");
    }
  }

  Future<JuzModel> getJuzz(int index) async {
    
    String url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //throw Exception('abcd');
      return JuzModel.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed to load post");
    }
  }

  Future<List<Sajda>> getSajda() async {
    
    String url = "http://api.alquran.cloud/v1/sajda/quran-uthmani";
    Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String,dynamic> jsonData = jsonDecode(response.body);
      List<Sajda> list = [];
      jsonData['data']['ayahs'].forEach((element){
        list.add(Sajda.fromJSON(element));
      });
      print('ol ${list.length}');
      return list;
    } else {
      throw ("Can't get the Surah");
    }
  }

  Future<SurahTranslationList> getTranslation(int index, int translationIndex) async {
    
    print("lan_index ${translationIndex}");
    String lan = "";
    if (translationIndex == 0) {
      lan = "english_saheeh";
    } else if (translationIndex == 1){
      lan = "bengali_zakaria";
    }

    String url = "https://quranenc.com/api/v1/translation/sura/$lan/$index";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return SurahTranslationList.fromJSON(json.decode(response.body));
    } else {
      throw ("Can't get the Surah");
    }
  }

  Future<List<Quri>> getQuriList() async {
    
    String url = "https://quranicaudio.com/api/qaris";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<Quri> quriList = [];
      jsonDecode(response.body).forEach((element){
        quriList.add(Quri.fromJSON(element));
      });;
      quriList.sort((a, b) => a.name!.compareTo(b.name!));
      return quriList;
    } else {
      throw ("Can't get the Quri");
    }
  }
}