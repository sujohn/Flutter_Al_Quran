
import 'package:al_quran_app/services/api_services.dart';
import 'package:al_quran_app/widgets/quri_custom_tile.dart';
import 'package:flutter/material.dart';

import '../models/quri.dart';

class QuriListScreen extends StatefulWidget {
  const QuriListScreen({ Key? key }) : super(key: key);

  @override
  _QuriListScreenState createState() => _QuriListScreenState();
}

class _QuriListScreenState extends State<QuriListScreen> {
  
  ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Quri's"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox( height: 4,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 1,
                      spreadRadius: 0.0,
                      offset: Offset(0,1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Search'),
                      Spacer(),
                      Icon(Icons.search),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: FutureBuilder(
                  future: _apiServices.getQuriList(),
                  builder: (context, AsyncSnapshot<List<Quri>> snapshot){
                    if (snapshot.hasError) {
                      return Center(child: Text('Quri\'s data not found'),);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return QuriCustomTile(quri: snapshot.data![index], ontap: () {
                          print("Quri: ${snapshot.data![index].name}");
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}