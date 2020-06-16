

import 'dart:async';
import 'dart:convert';

import 'package:expensestracker/Data/data_provider.dart';
import 'package:expensestracker/models/Records.dart';
import 'package:expensestracker/models/categoryModel.dart';
import 'package:expensestracker/models/chart.dart';
import 'package:expensestracker/models/recentFiveRecords.dart';
import 'package:expensestracker/models/successUsers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../main.dart';
import 'createRecord.dart';

class Home extends StatefulWidget {
  final loginUsers currentUsers;
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
  Timer timer;
  bool _hasData;
  double totalIncome, totalExpense;
  static const API = 'http://expenses.koda.ws/';
  Future<RecordsModel> loadRecords() async{
    final recordResponse = await dataProvider().fetchRecords(widget.currentUsers);
    final fiveRecordResponse = await dataProvider().fetchFiveRecords(widget.currentUsers);
    final categoryResponse = await dataProvider().fetchCategory();
    //print("Result ");
    print("response "+fiveRecordResponse.records[1].amount.toString());
    setState(() {
      if(recordResponse==null) {
        _hasData = false;
        print("No record found");
      }
      else {
        recordData = recordResponse;
        fiveRecords = fiveRecordResponse;
        categoryModel = categoryResponse;
        _hasData = true;
        totalExpense = 0;
        totalIncome = 0;
        for(int ctr = 0; ctr<recordData.records.length;ctr++)
        {
          if(recordData.records[ctr].recordType==0)
          {
            totalIncome+=recordData.records[ctr].amount;
          }
          else if(recordData.records[ctr].recordType==1)
          {
            totalExpense+=recordData.records[ctr].amount;
          }
        }
        print(totalIncome.toString()+" "+totalExpense.toString());

        print("Record succssfully fetch");
      }
    });
    return recordResponse;
  }
  @override
  void initState() {
    super.initState();
    timer = new Timer.periodic(new Duration(seconds: 2), (t) => loadRecords());
    //timer = new Timer.periodic(new Duration(seconds: 2), (t) => fetchFiveRecords());

  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: Text("Home",),
        ),
        body: (_hasData==null)?CircularProgressIndicator():(_hasData)?
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
                            return ListTile(
                               //contentPadding: EdgeInsets.all(0.0),
                              title: Text("₱ "+fiveRecords.records[index].amount.toString(),
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.green,
                                ),),
                              subtitle: Text(fiveRecords.records[index].category.name.toString()+"  ---"+ fiveRecords.records[index].notes.toString(),
                                style: TextStyle(
                                  fontSize: 10.0
                                ),),
                              leading: Image.network(API+
                                  categoryModel.categories[fiveRecords.records[index].category.id-1].icon,
                                  fit: BoxFit.fill),
                              trailing: Text("date here"),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => createRecord(widget.currentUsers)),);
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
        drawer: createDrawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: (){
            print(widget.currentUsers.token);
            Navigator.push(context, MaterialPageRoute(builder: (context) => createRecord(widget.currentUsers)),
            );
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
        chartModel('Expense', totalExpense),
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
class createDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => createDrawerState();
}

class createDrawerState extends State<createDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
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
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
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
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      MyApp()), (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        )
    );
  }
}
