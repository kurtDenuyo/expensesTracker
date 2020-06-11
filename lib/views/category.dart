
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:expensestracker/Data/data_provider.dart';
import 'package:expensestracker/models/category.dart';
import 'package:flutter/material.dart';
class category extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _categoryState();
}
class _categoryState extends State<category> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Select Category",
        style: TextStyle(
          fontFamily: 'Nunito-Regular'
        ),),
      ),
      body: createBody(),
    );
  }
}
class createBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _createBodyState();
}
class _createBodyState extends State<createBody> {
  static const API = 'http://expenses.koda.ws/';
  Future<Categories> loadCategory() async{
    final result = await http.get(
      API + 'api/v1/categories',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    //print(result.body);
    print(Categories.fromJson(jsonDecode(result.body)).name);
    return Categories.fromJson(jsonDecode(result.body));

}
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        FutureBuilder(
          future: loadCategory(),
          builder: (context,AsyncSnapshot<Categories> result){
            if(result.hasData)
              {
                return Text(result.toString());
              }
            return CircularProgressIndicator();
          },
        )
      ],
    );
  }

}