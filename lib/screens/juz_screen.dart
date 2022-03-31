

import 'package:al_quran_app/constants/constants.dart';
import 'package:al_quran_app/models/juz.dart';
import 'package:al_quran_app/services/api_services.dart';
import 'package:al_quran_app/widgets/juz_custom_list_tile.dart';
import 'package:flutter/material.dart';

class JuzScreen extends StatelessWidget {
  static const String id = 'juz_screen';

  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<JuzModel>(
          future: apiServices.getJuzz(Constants.juzIndex!),
          builder: (context, AsyncSnapshot<JuzModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            } else if (snapshot.hasData) {

              int count = snapshot.data!.juzAyahs.length;
              print('${count} length');
              return ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) {
                  return JuzCustomListTile(list: snapshot.data!.juzAyahs, index: index,);
                },
              );
            } else {
              return Center(child: Text('No data found'),);
            }
          },
        ),
      ),
    );
  }
}