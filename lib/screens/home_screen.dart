
import 'package:al_quran_app/models/aya_of_the_day.dart';
import 'package:al_quran_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  var _hijri = HijriCalendar.now();
  ApiServices _apiServices = ApiServices();
  AyaOfTheDay? data;

  void setData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("alreadyUsed", true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }
  
  @override
  Widget build(BuildContext context) {

    var _size = MediaQuery.of(context).size;
    HijriCalendar.setLocal('ar');
    var day = DateTime.now();
    var format = DateFormat('EEE d MMM yyyy');
    var formatted = format.format(day);
    
    //_apiServices.getAyaOfTheDay().then((value) => data = value);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: _size.height * 0.22,
              width: double.infinity,
              decoration: BoxDecoration( 
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/background_img.jpg'),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formatted, style: TextStyle(color: Colors.white, fontSize: 30),),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${_hijri.hDay} ${_hijri.longMonthName} ${_hijri.hYear} AH',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ]
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsetsDirectional.only(top: 10, bottom: 20),
                child: Column(
                  children: [
                    FutureBuilder<AyaOfTheDay>(
                      future: _apiServices.getAyaOfTheDay(),
                      builder: (context, snapshot) {
                        switch(snapshot.connectionState){
                          case ConnectionState.none:
                            return Icon(Icons.sync_problem);
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            return CircularProgressIndicator();
                          case ConnectionState.done:
                            return Container(
                              margin: EdgeInsetsDirectional.all(16),
                              padding: EdgeInsetsDirectional.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    offset: Offset(0, 0),
                                    color: Colors.blueGrey,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text("Quran Aya of the Day", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                  Divider(color: Colors.black, thickness: 0.5,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(snapshot.data!.arText!, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                                  ),
                                  Text(snapshot.data!.enTran!, style: TextStyle(color: Colors.black54),),
                                  RichText(
                                    text: TextSpan(
                                      children: <InlineSpan>[
                                        WidgetSpan(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(snapshot.data!.surNumber!.toString()),
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(snapshot.data!.surEnName!),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}