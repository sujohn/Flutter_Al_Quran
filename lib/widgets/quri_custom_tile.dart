import 'package:al_quran_app/models/quri.dart';
import 'package:flutter/material.dart';

class QuriCustomTile extends StatefulWidget {
  const QuriCustomTile({ Key? key, required this.quri, required this.ontap }) : super(key: key);

  final Quri quri;
  final VoidCallback ontap;

  @override
  _QuriCustomTileState createState() => _QuriCustomTileState();
}

class _QuriCustomTileState extends State<QuriCustomTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 0,
                color: Colors.black12,
                offset: Offset(0,1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.quri.name!, textAlign: TextAlign.start, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}