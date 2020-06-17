

import 'dart:async';
import 'dart:convert';

import 'package:expensestracker/Data/data_provider.dart';
import 'package:expensestracker/models/Records.dart';
import 'package:expensestracker/models/categoryModel.dart';
import 'package:expensestracker/models/chart.dart';
import 'package:expensestracker/models/recentFiveRecords.dart';
import 'package:expensestracker/models/usersModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../main.dart';
import 'allRecordsView.dart';
import 'createRecord.dart';
import 'editRecord.dart';

class Home extends StatefulWidget {
  final UserModel currentUsers;
  const Home(this.currentUsers);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('You are about to log out!'),
        content: new Text('Please confirm'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("Cancel    "),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text("    Log out"),
          ),
        ],
      ),
    ) ??
        false;
  }
  RecordsModel recordData;
  RecentFiveRecords fiveRecords;
  CategoryModel categoryModel;
  bool _hasData;
  double totalIncome, totalExpenses;
  static const API = 'http://expenses.koda.ws/';
  Future<RecordsModel> loadRecords() async{
    final recordResponse = await dataProvider().fetchRecords(widget.currentUsers);
    final fiveRecordResponse = await dataProvider().fetchFiveRecords(widget.currentUsers);
    final categoryResponse = await dataProvider().fetchCategory();
    final overviewResponse = await dataProvider().fetchOverview(widget.currentUsers);
    //print("Result ");
    //print("Total content "+recordResponse.records.length.toString());
   // print("response "+fiveRecordResponse.records[1].amount.toString());
    print("Total expenses"+overviewResponse.expenses.toString());
    print("Total income"+overviewResponse.income.toString());
    setState(() {
      if(recordResponse.records.length == 0) {
        _hasData = false;
        print("No record found");
      }
      else {
        recordData = recordResponse;
        fiveRecords = fiveRecordResponse;
        categoryModel = categoryResponse;
        totalIncome = overviewResponse.income;
        totalExpenses = overviewResponse.expenses;
        _hasData = true;
        print("Record succssfully fetch");
      }
    });
    return recordResponse;
  }
  void _refreshHome() async{
    loadRecords();
  }
  @override
  void initState() {
    super.initState();
    print("Load records");
    loadRecords();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //loadRecords();
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: Text("Home",),
        ),
        body: (_hasData==null)?
        Center(
          child: SpinKitWave(color: Colors.blueGrey, type: SpinKitWaveType.center),
        )
            :(_hasData)?
            Center(
                child: Padding(
                 padding:EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding:EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Text("OVERVIEW",
                            style: TextStyle(
                              fontSize: 16.0,
                                fontFamily: 'Nunito-Bold'
                            ),),
                        ),
                        Container(
                          padding:EdgeInsets.only(left: 20.0,bottom: 20.0),
                          child: SizedBox(
                            height: 100.0,
                            width: 300.0,
                            child: createChart(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding:EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Text("RECENT",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Nunito-Bold'
                            ),),
                        ),
                        ListView.builder(
                          padding:EdgeInsets.only(left: 20.0,right: 20.0),
                          shrinkWrap: true,
                          itemCount: fiveRecords.records.length,
                          itemBuilder: (BuildContext contex, int index)
                          {
                            String month = "";
                            switch(fiveRecords.records[fiveRecords.records.length-(index+1)].date.month) {
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
                            print("index counter "+(fiveRecords.records.length-(index+1)).toString()+index.toString());
                            return ListTile(
                               //contentPadding: EdgeInsets.all(0.0),
                              title: Text("₱ "+fiveRecords.records[fiveRecords.records.length-(index+1)].amount.toString(),
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.green,
                                ),),
                              subtitle: Text(fiveRecords.records[fiveRecords.records.length-(index+1)].category.name.toString()+"  ---"+ fiveRecords.records[fiveRecords.records.length-(index+1)].notes.toString(),
                                style: TextStyle(
                                  fontSize: 10.0
                                ),),
                              leading: Image.network(API+
                                  categoryModel.categories[fiveRecords.records[fiveRecords.records.length-(index+1)].category.id-1].icon,
                                  fit: BoxFit.fill),
                              trailing: Text(month+" "+fiveRecords.records[fiveRecords.records.length-(index+1)].date.day.toString()+" , "+fiveRecords.records[fiveRecords.records.length-(index+1)].date.year.toString(),
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
                      ],
                    ),
                  ),
                  Container(
                    height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1),
                      ),
                    child: Center(
                      child: new InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => allRecords(widget.currentUsers)),)
                              .then((value) => value?_refreshHome():null);
                        },
                        child: new Text('View More',
                            style: TextStyle(
                              fontFamily: 'Nunito-Regular',
                              fontSize: 16.0
                            )
                        ),
                      )
                    )
                  )
                ],
              )
            )
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
        drawer: Drawer(
            child: Container(
              color: Colors.teal,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  SizedBox(
                    height: 150.0,
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.home),
                        Padding(
                          padding:EdgeInsets.only(left:10.0),
                          child: Text('HOME',
                            style: TextStyle(
                                fontFamily: 'Nunito-Regular'
                            ),),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context,true);
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.category),
                        Padding(
                          padding:EdgeInsets.only(left:8.0),
                          child: Text('RECORDS',
                            style: TextStyle(
                                fontFamily: 'Nunito-Regular'
                            ),),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => allRecords(widget.currentUsers)),)
                          .then((value) => value?_refreshHome():null);
                    },
                  ),

                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.settings_power),
                        Padding(
                          padding:EdgeInsets.only(left:8.0),
                          child: Text('LOGOUT',
                            style: TextStyle(
                                fontFamily: 'Nunito-Regular'
                            ),),
                        )
                      ],
                    ),
                    onTap: () {
                      dispose();
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          MyApp()), (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            )
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: (){
            print(widget.currentUsers.token);
            Navigator.push(context, MaterialPageRoute(builder: (context) => createRecord(widget.currentUsers)),)
            .then((value) => value?_refreshHome():null);
          },
          child: Icon(Icons.add),
        ), //
      ),
    );

  }
  charts.Series<chartModel, String> createSeries(String id, int i){
    final green = charts.MaterialPalette.green.makeShades(2);
    final red = charts.MaterialPalette.red.makeShades(2);
     //int totalIncome
    return charts.Series<chartModel, String>(
      id:id,
      domainFn: (chartModel wear, _) => wear.recordType,
      measureFn: (chartModel wear,_) => wear.total,
      data: [
        chartModel('Income', totalIncome),
        chartModel('Expense', totalExpenses),
      ],
      colorFn: (chartModel wear,_){
        switch (wear.recordType){
          case "Income":
            {
              return green[1];
            }
          case "Expense":
            {
              return red[1];
            }
          default:
            {
              return red[0];
            }
        }
      },
    );
  }

  createChart() {
    List<charts.Series<chartModel, String>> seriesList = [];
    for(int i = 0; i<1; i++){
      String id = 'recordType${i}';
      seriesList.add(createSeries(id, i));
    }
    return new charts.BarChart(
      seriesList,
      vertical: false,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }
}