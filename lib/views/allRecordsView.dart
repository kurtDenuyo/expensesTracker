
import 'dart:async';
import 'dart:convert';
import 'package:expensestracker/Data/data_provider.dart';
import 'package:expensestracker/models/Records.dart';
import 'package:expensestracker/models/categoryModel.dart';
import 'package:expensestracker/models/usersModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'createRecord.dart';
import 'editRecord.dart';
class allRecords extends StatefulWidget {
  final UserModel currentUsers;
  const allRecords(this.currentUsers);
  @override
  State<StatefulWidget> createState() => _allRecordsState();
}
class _allRecordsState extends State<allRecords> {
  RecordsModel recordData;
  CategoryModel categoryModel;
  bool _hasData;
  bool _showSearchTextField;
  final TextEditingController _searchText = TextEditingController();
  static const API = 'http://expenses.koda.ws/';
  Future<RecordsModel> loadRecords() async{
    final recordResponse = await dataProvider().fetchRecords(widget.currentUsers);
    final categoryResponse = await dataProvider().fetchCategory();
    //print("Result ");
    //print("Total content "+recordResponse.records[0].category.name.toString());
    // print("response "+fiveRecordResponse.records[1].amount.toString());
    setState(() {
      if(recordResponse.records.length == 0) {
        print("No record found");
        _hasData = false;
      }
      else {
        recordData = recordResponse;
        categoryModel = categoryResponse;
        _hasData = true;
        print("Record succssfully fetch");
      }
    });
    return recordResponse;
  }
  @override
  void initState() {
    super.initState();
    loadRecords();
    _showSearchTextField = false;
  }
  void _refreshHome() async{

    loadRecords();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context,true),
        ),
        title: _showSearchTextField?
        TextField(
          controller: _searchText,
          autofocus: false,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
          decoration: new InputDecoration(
              hintStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: 'Nunito-Regular'),
              hintText: "Search...",
              prefixIcon: new Icon(Icons.search,color: Colors.white,)),
        )
            :
        Text("Records",
          style: TextStyle(
              fontFamily: 'Nunito-Regular'
          ),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: ()
            {
              setState(() {
                _showSearchTextField = true;
              });
              //_searchRecord();
            },
          ),
        ],
      ),
      body: (_hasData==null)?
      Center(
        child: SpinKitWave(color: Colors.blueGrey, type: SpinKitWaveType.center),
      )
          :(_hasData)?
      ListView.builder(
        padding:EdgeInsets.only(left: 20.0,right: 20.0),
        shrinkWrap: true,
        itemCount: recordData.records.length,
        itemBuilder: (BuildContext contex, int index)
        {
          String month = "";
          switch(recordData.records[recordData.records.length-(index+1)].date.month) {
            case 1: {
              month = "Jan";
              print(month);
            }
            break;

            case 2: {
              month = "Feb";
              print(month);
            }
            break;
            case 3: {
              month = "Mar";
              print(month);
            }
            break;
            case 4: {
              month = "Apr";
              print(month);
            }
            break;
            case 5: {
              month = "May";
              print(month);
            }
            break;
            case 6: {
              month = "Jun";
              print(month);
            }
            break;
            case 7: {
              month = "July";
              print(month);
            }
            break;
            case 8: {
              month = "Aug";
              print(month);
            }
            break;
            case 9: {
              month = "Sep";
              print(month);
            }
            break;
            case 10: {
              month = "Oct";
              print(month);
            }
            break;
            case 11: {
              month = "Nov";
              print(month);
            }
            break;

            default: {
              month = "Dec";
              print(month);
            }
            break;
          }
          print("index counter "+(recordData.records.length-(index+1)).toString()+index.toString());
          return ListTile(
            //contentPadding: EdgeInsets.all(0.0),
            title: Text("₱ "+recordData.records[recordData.records.length-(index+1)].amount.toString(),
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.green,
              ),),
            subtitle: Text(recordData.records[recordData.records.length-(index+1)].category.name.toString()+"  ---"+ recordData.records[recordData.records.length-(index+1)].notes.toString(),
              style: TextStyle(
                  fontSize: 10.0
              ),),
            leading: Image.network(API+
                categoryModel.categories[recordData.records[recordData.records.length-(index+1)].category.id-1].icon,
                fit: BoxFit.fill),
            trailing: Text(month+" "+recordData.records[recordData.records.length-(index+1)].date.day.toString()+" , "+recordData.records[recordData.records.length-(index+1)].date.year.toString(),
              style: TextStyle(
                fontSize: 10.0,
              ),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => editRecord(widget.currentUsers, recordData, recordData.records.length-(index+1))))
                  .then((value) => value?_refreshHome():null);
            },
          );
        },
      )
          :
      Container(
        color: Colors.green[100],
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60.0,
              ),
              SizedBox(
                height: 120.0,
                width: 450.0,
                child: Image.asset(
                  "assets/images/empty_icon.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("There are no records here yet.",
                style: TextStyle(
                  fontFamily: 'Nunito-Regular',
                  fontSize: 16.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                height: 140.0,
              ),
              SizedBox(
                height: 60.0,
                width: 300.0,
                child: RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.white70,
                  textColor: Colors.black,
                  onPressed: (){

                    //loadRecords();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => createRecord(widget.currentUsers)),)
                        .then((value) => value?_refreshHome():null);
                  },
                  child: new Text("START TRACKING",
                    style: TextStyle(
                        fontFamily: 'Nunito-Bold',
                        fontSize: 20.0
                    ),),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _searchRecord() async{
    final response = await dataProvider().deleteRecord(widget.currentUsers, "Search Text");
    print(response.body);
    if(response.statusCode==200)
    {
      print("Status: Delete Success");
      Navigator.pop(context,true);
    }
    else
    {
      showDialog(
          context: context,
          builder: (BuildContext context){
            return SizedBox(
              child: AlertDialog(
                title: Text("Error Message"),
                content: Text(response.body),
                actions:[
                  FlatButton(
                    child: Text("Retry",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.redAccent
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
          }
      );
    }
  }
}
