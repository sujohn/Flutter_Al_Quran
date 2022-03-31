import 'package:al_quran_app/constants/constants.dart';
import 'package:al_quran_app/models/surah_translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SurahTranslationTile extends StatelessWidget {
  
  final SurahTranslation surahTranslation;
  final int index;

  SurahTranslationTile({required this.surahTranslation, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Constants.kPrimary,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
                ),
              ),
              Positioned(
                top: 3,
                left: 12,
                child: Container(
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Text(surahTranslation.aya!, style: TextStyle(color: Colors.white, fontSize: 16),),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(surahTranslation.arabic_text!, style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),),
                Text(surahTranslation.translation!, style: TextStyle(color: Colors.black, fontSize: 18, ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}