
import 'package:expensestracker/Data/data_provider.dart';
import 'package:expensestracker/models/Records.dart';
import 'package:expensestracker/models/usersModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../main.dart';
import 'category.dart';

class editRecord extends StatefulWidget {
  final UserModel currentUsers;
  final RecordsModel record;
  final int index;
  const editRecord(this.currentUsers, this.record, this.index);
  @override
  State<StatefulWidget> createState() => _editRecordState();
}

class _editRecordState extends State<editRecord> with SingleTickerProviderStateMixin{
  TabController _controller;
  final TextEditingController _categoryController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final  _recordTypeController = 0;
  int categoryId;
  @override
  void initState() {
    super.initState();
    _categoryController.text = widget.record.records[widget.index].category.name;
    _notesController.text = widget.record.records[widget.index].notes;
    _amountController.text = widget.record.records[widget.index].amount.toString();
    categoryId = widget.record.records[widget.index].category.id;
    //_dateController.text = widget.record.records[widget.index].amount.toString();
    //_timeController.text = widget.record.records[widget.index].amount.toString();
    _controller = new TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {


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
    _dateController.text = month+"-"+widget.record.records[widget.index].date.day.toString()+"-"+widget.record.records[widget.index].date.year.toString();
    _timeController.text = DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text("Edit Record",),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: ()
            {
              _deleteRecord();
            },
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: ()
            {
              _editRecord();
            },
          ),
        ],
      ),
      body: Form(
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
                          border: Border.all(color: Colors.black12, width: 1),
                        ),
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
                                            return 'Please enter note';
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
                                            return 'Please enter amount';
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
                                            onTap: () async{

                                              List result = await Navigator.push(context, MaterialPageRoute(builder: (context) => category()),
                                              );
                                              setState(() {
                                                _categoryController.text = result[0].toString();
                                                categoryId = result[1];
                                                print(result[1]);
                                              });
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
                                            return 'Please enter note';
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
                                            return 'Please enter amount';
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
                                            onTap: () async{
                                              List result = await Navigator.push(context, MaterialPageRoute(builder:(context)=>category()));
                                              _categoryController.text = result[0].toString();
                                              categoryId = result[1];
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

  void _editRecord() async{
    if (_formKey.currentState.validate()) {
      if(categoryId==null)
      {
        print("Category id: "+ categoryId.toString());
        showDialog(
            context: context,
            builder: (BuildContext context){
              return SizedBox(
                child: AlertDialog(
                  title: Text("Error Message"),
                  content: Text("No Category Selected"),
                  actions:[
                    FlatButton(
                      child: Text("Select",
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
      else
      {
        final record = {
          "record": {
            "amount": _amountController.text,
            "notes": _notesController.text,
            "record_type": _controller.index,
            "date": _dateController.text,
            "category_id": categoryId,
          }
        };
        dataProvider().token(widget.currentUsers.token);
        final response = await dataProvider().editRecord(record, widget.currentUsers, widget.record.records[widget.index].id.toString());
        //print(widget.currentUsers.token);

        if(response.statusCode==200)
        {
          print("Status  Update success");
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
                          Navigator.pop(context,true);
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

  }
  void _deleteRecord() async{
    final response = await dataProvider().deleteRecord(widget.currentUsers, widget.record.records[widget.index].id.toString());
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

