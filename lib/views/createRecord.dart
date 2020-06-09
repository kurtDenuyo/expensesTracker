

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class createRecord extends StatefulWidget {
  createRecord({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _createRecordState();
}

class _createRecordState extends State<createRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text("Add Record",),
      ),
      body: Container(
        color: Colors.green[100],
        child: Center(
          child: Column(
            children: <Widget>[

            ],
          ),
        ),
      ),
    );

  }
}