
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
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
  int present, perPage;
  RecordsModel recordData, searchResults, paginationRecord;
  CategoryModel categoryModel;
  bool _hasData;
  bool activeSearch;
  bool _searchHasData;
  final TextEditingController _searchText = TextEditingController();
  Color textColor = Colors.green;
  static const API = 'http://expenses.koda.ws/';
  Future<RecordsModel> loadRecords() async{
    RecordsModel recordResponse = await dataProvider().fetchRecords(widget.currentUsers);
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
        //present = present + recordResponse.pagination.current;
       // perPage = recordResponse.pagination.perPage;
        paginationRecord = recordData;
        _hasData = true;
        print(present.toString()+" Page "+perPage.toString());
        print("Record succssfully fetch");
      }
    });
    return recordResponse;
  }
  @override
  void initState() {
    super.initState();
    loadRecords();
    activeSearch = false;
    _searchHasData = false;
  }
  void backLoadMore() async{
    print("Reach buttom: Load more");
    if(recordData.pagination.current > 1)
    {
      paginationRecord = await dataProvider().seed(widget.currentUsers, recordData.pagination.previousUrl);
      print("recordData "+ recordData.records.length.toString());
      print("paginationrecord "+paginationRecord.records.length.toString());
      print("final records "+ recordData.records.length.toString());
      setState(() {
        recordData = paginationRecord;
        //recordData.records.addAll(paginationRecord.records);
        //paginationRecord.records = null;
        // print("Current page "+ recordData.pagination.current.toString());
        //_refreshHome();
      });
    }
    else
    {
      print("Youre in top");
    }

  }
  void loadMore() async{
    print("Reach buttom: Load more");
    if(recordData.pagination.current < recordData.pagination.pages)
      {
        paginationRecord = await dataProvider().seed(widget.currentUsers, recordData.pagination.nextUrl);
        print("recordData "+ recordData.records.length.toString());
        print("paginationrecord "+paginationRecord.records.length.toString());
        print("final records "+ recordData.records.length.toString());
        setState(() {
          recordData = paginationRecord;
          //recordData.records.addAll(paginationRecord.records);
          //paginationRecord.records = null;
         // print("Current page "+ recordData.pagination.current.toString());
          //_refreshHome();
        });
      }
    else
      {
        print("End of records");
      }

  }

  void _refreshHome() async{

    loadRecords();
  }
  @override
  void dispose() {
    super.dispose();
  }
  PreferredSizeWidget _appBar() {
    if (activeSearch) {
      return AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context,true),
        ),
        title:  TextField(
          controller: _searchText,
          onChanged: _search,
          autofocus: false,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
          decoration: new InputDecoration(
              hintStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: 'Nunito-Regular'),
              hintText: "Search...",
              prefixIcon: new Icon(Icons.search,color: Colors.white,)),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                activeSearch = false;
                _searchHasData = false;
                _searchText.text = "";
              });
            },
          )
        ],
      );
    } else {
      return AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context,true),
        ),
        title: Text("Records",
          style: TextStyle(
              fontFamily: 'Nunito-Regular'
          ),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => setState(() => activeSearch = true),
          ),
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _appBar(),
      body: (_hasData==null)?
      Center(child: SpinKitWave(color: Colors.blueGrey, type: SpinKitWaveType.center),)
      :(_searchHasData)?
      Container(
        height: 1000.0,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo){
            if(scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent){
              loadMore();
            }
            if(scrollInfo.metrics.pixels == scrollInfo.metrics.minScrollExtent){
              backLoadMore();
            }
          },
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding:EdgeInsets.only(left: 20.0,right: 20.0),
            shrinkWrap: true,
            itemCount: (_searchHasData) ? searchResults.records.length : 0,
            itemBuilder: (BuildContext contex, int index)
            {
              String month = "";
              switch(searchResults.records[index].date.month) {
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
              if(searchResults.records[index].recordType==1)
              {
                textColor = Colors.red;
              }
              else
              {
                textColor = Colors.green;
              }
              return ListTile(
                //contentPadding: EdgeInsets.all(0.0),
                title: Text("₱ "+searchResults.records[index].amount.toString(),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: textColor,
                  ),),
                subtitle: Text(searchResults.records[index].category.name.toString()+"  ---"+ searchResults.records[index].notes.toString(),
                  style: TextStyle(
                      fontSize: 15.0
                  ),),
                leading: Image.network(API+
                    categoryModel.categories[searchResults.records[index].category.id-1].icon,
                    fit: BoxFit.fill),
                trailing: Text(month+" "+searchResults.records[index].date.day.toString()+" , "+searchResults.records[index].date.year.toString(),
                  style: TextStyle(
                    fontSize: 10.0,
                  ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => editRecord(widget.currentUsers, searchResults, index)))
                      .then((value) => value?_refreshHome():null);
                },
              );
            },
          ),
        )
      )
          :(_hasData)?
      Container(
        height: 1000.0,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo){
            if(scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent){
              loadMore();
            }
            if(scrollInfo.metrics.pixels == scrollInfo.metrics.minScrollExtent){
              backLoadMore();
            }
          },
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding:EdgeInsets.only(left: 20.0,right: 20.0),
            shrinkWrap: true,
            itemCount: recordData.records.length,
            itemBuilder: (BuildContext contex, int index)
            {
              String month = "";
              switch(recordData.records[index].date.month) {
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
              if(recordData.records[index].recordType==1)
              {
                textColor = Colors.red;
              }
              else
              {
                textColor = Colors.green;
              }
              return ListTile(
                //contentPadding: EdgeInsets.all(0.0),
                title: Text("₱ "+recordData.records[index].amount.toString(),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: textColor,
                  ),),
                subtitle: Text(recordData.records[index].category.name.toString()+"  ---"+ recordData.records[index].notes.toString(),
                  style: TextStyle(
                      fontSize: 15.0
                  ),),
                leading: Image.network(API+
                    categoryModel.categories[recordData.records[index].category.id-1].icon,
                    fit: BoxFit.fill),
                trailing: Text(month+" "+recordData.records[index].date.day.toString()+" , "+recordData.records[index].date.year.toString(),
                  style: TextStyle(
                    fontSize: 10.0,
                  ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => editRecord(widget.currentUsers, recordData, index)))
                      .then((value) => value?_refreshHome():null);
                },
              );
            },
          ),
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
    );
  }
  void _search(String value) async{
    print("Search this "+value);
    final recordResponse = await dataProvider().searchRecord(widget.currentUsers, value);

    if(recordResponse.records.length>0){
      setState(() {
        searchResults = recordResponse;
        _searchHasData = true;
      });
    }
    else
      {
        _searchHasData = false;
      }

  }
}

