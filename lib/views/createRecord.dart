
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../main.dart';
import 'category.dart';

class createRecord extends StatefulWidget {
 // createRecord({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _createRecordState();
}

class _createRecordState extends State<createRecord> with SingleTickerProviderStateMixin{
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _notesController = TextEditingController();
    final TextEditingController _amountController = TextEditingController();
    final TextEditingController _dateController = TextEditingController();
    final TextEditingController _timeController = TextEditingController();
    final TextEditingController _categoryController = TextEditingController();
    String month = "";
    switch(DateTime.now().month.toInt()) {
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
    _dateController.text = month+"-"+DateTime.now().day.toString()+"-"+DateTime.now().year.toString();
    _timeController.text = DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();
    _categoryController.text = "Food & Drinks";
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text("Add Record",),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: ()
            {
            },
          ),
        ],
      ),
      body: new Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ClipRRect(
                child: Container(
                  height: 290.0,
                  margin: const EdgeInsets.only(top: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      new Container(
                        decoration: new BoxDecoration(color: Colors.white70,
                          border: Border.all(color: Colors.black12, width: 1),),
                          child: new TabBar(
                          labelStyle: TextStyle(fontFamily: 'Nunito-Regular',color: Colors.green),  //For Selected tab
                          unselectedLabelStyle: TextStyle(fontFamily: 'Nunito-Regular',color: Colors.black), //For Un-selected Tabs
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.green,
                          //unselectedLabelColor: Colors.white,
                          indicator: (BoxDecoration(

                            color: Colors.green[100],
                          )),
                          controller: _controller,
                          tabs: [
                            new Tab(
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Income",
                                  ),
                                ),
                              ),
                            ),
                            new Tab(
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Expenses",),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Expanded(
                        child: TabBarView(
                          controller: _controller,
                          children: <Widget>[
                            new Card(
                                child: SizedBox(
                                  child:  Column(
                                    children: <Widget>[
                                      TextFormField(
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                          focusedBorder:OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                          ),
                                          labelStyle: TextStyle(
                                              fontSize: 12.0
                                          ),
                                          labelText: "  Notes",
                                        ),
                                        controller: _notesController,
                                        obscureText: false,
                                        validator: (value){
                                          if(value.isEmpty){
                                            return 'Please enter a name';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                            fontFamily: 'Nunito-Regular'
                                        ),
                                      ),
                                      TextFormField(
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                          focusedBorder:OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                          ),
                                          labelStyle: TextStyle(
                                              fontSize: 12.0
                                          ),
                                          labelText: "  Amount",
                                        ),
                                        controller: _amountController,
                                        obscureText: false,
                                        validator: (value){
                                          if(value.isEmpty){
                                            return 'Please enter an email';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                            fontFamily: 'Nunito-Regular'
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: new TextFormField(
                                                controller: _dateController,
                                                cursorColor: Colors.green,
                                                decoration: InputDecoration(
                                                    focusedBorder:OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                                    ),
                                                    labelText: "  Date"
                                                ),
                                                onTap: (){
                                                  DatePicker.showDatePicker(context,
                                                      showTitleActions: true,
                                                      minTime: DateTime(2000, 3, 5),
                                                      maxTime: DateTime(2100, 6, 7),
                                                      onChanged: (date) {
                                                        print('change $date');
                                                      },
                                                      onConfirm: (date) {
                                                        //_dateController.text = date.toIso8601String();
                                                        switch(date.month.toInt()) {
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
                                                        _dateController.text = month+"-"+date.day.toString()+"-"+date.year.toString();
                                                        print('confirm $date');
                                                      },
                                                      currentTime: DateTime.now(), locale: LocaleType.en);
                                                },
                                              )
                                          ),
                                          Expanded(
                                              child: new TextFormField(
                                                controller: _timeController,
                                                cursorColor: Colors.green,
                                                decoration: InputDecoration(
                                                    focusedBorder:OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                                    ),
                                                    labelText: "  Time"
                                                ),
                                                onTap: (){
                                                  DatePicker.showTimePicker(context,
                                                    showSecondsColumn: false,
                                                    showTitleActions: true,
                                                    currentTime: DateTime.now(),
                                                    locale: LocaleType.en,
                                                    onChanged: (time) {
                                                      print('change $time');
                                                    },
                                                    onConfirm: (time) {
                                                      //_dateController.text = date.toIso8601String();
                                                      _timeController.text = time.hour.toString()+":"+time.minute.toString();
                                                      print('confirm $time');
                                                    },
                                                  );
                                                },
                                              )
                                          )
                                        ],
                                      ),
                                      Expanded(
                                          child: new TextFormField(
                                            controller: _categoryController,
                                            cursorColor: Colors.green,
                                            decoration: InputDecoration(
                                                focusedBorder:OutlineInputBorder(
                                                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                                ),
                                                labelText: "  Category"
                                            ),
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => category()),
                                              );
                                            },
                                          )
                                      )
                                    ],
                                  ),
                                )
                            ),
                            new Card(
                                child: SizedBox(
                                  child:  Column(
                                    children: <Widget>[
                                      TextFormField(
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                          focusedBorder:OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                          ),
                                          labelStyle: TextStyle(
                                              fontSize: 12.0
                                          ),
                                          labelText: "  Notes",
                                        ),
                                        controller: _notesController,
                                        obscureText: false,
                                        validator: (value){
                                          if(value.isEmpty){
                                            return 'Please enter a name';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                            fontFamily: 'Nunito-Regular'
                                        ),
                                      ),
                                      TextFormField(
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                          focusedBorder:OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                          ),
                                          labelStyle: TextStyle(
                                              fontSize: 12.0
                                          ),
                                          labelText: "  Amount",
                                        ),
                                        controller: _amountController,
                                        obscureText: false,
                                        validator: (value){
                                          if(value.isEmpty){
                                            return 'Please enter an email';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                            fontFamily: 'Nunito-Regular'
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: new TextFormField(
                                                controller: _dateController,
                                                cursorColor: Colors.green,
                                                decoration: InputDecoration(
                                                    focusedBorder:OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                                    ),
                                                    labelText: "  Date"
                                                ),
                                                onTap: (){
                                                  DatePicker.showDatePicker(context,
                                                      showTitleActions: true,
                                                      minTime: DateTime(2000, 3, 5),
                                                      maxTime: DateTime(2100, 6, 7),
                                                      onChanged: (date) {
                                                        print('change $date');
                                                      },
                                                      onConfirm: (date) {
                                                        //_dateController.text = date.toIso8601String();
                                                        switch(date.month.toInt()) {
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
                                                        _dateController.text = month+"-"+date.day.toString()+"-"+date.year.toString();
                                                        print('confirm $date');
                                                      },
                                                      currentTime: DateTime.now(), locale: LocaleType.en);
                                                },
                                              )
                                          ),
                                          Expanded(
                                              child: new TextFormField(
                                                controller: _timeController,
                                                cursorColor: Colors.green,
                                                decoration: InputDecoration(
                                                    focusedBorder:OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                                    ),
                                                    labelText: "  Time"
                                                ),
                                                onTap: (){
                                                  DatePicker.showTimePicker(context,
                                                    showSecondsColumn: false,
                                                    showTitleActions: true,
                                                    currentTime: DateTime.now(),
                                                    locale: LocaleType.en,
                                                    onChanged: (time) {
                                                      print('change $time');
                                                    },
                                                    onConfirm: (time) {
                                                      //_dateController.text = date.toIso8601String();
                                                      _timeController.text = time.hour.toString()+":"+time.minute.toString();
                                                      print('confirm $time');
                                                    },
                                                  );
                                                },
                                              )
                                          )
                                        ],
                                      ),
                                      Expanded(
                                          child: new TextFormField(
                                            controller: _categoryController,
                                            cursorColor: Colors.green,
                                            decoration: InputDecoration(
                                                focusedBorder:OutlineInputBorder(
                                                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                                ),
                                                labelText: "  Category"
                                            ),
                                            onTap: (){

                                            },
                                          )
                                      )
                                    ],
                                  ),
                                )
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}