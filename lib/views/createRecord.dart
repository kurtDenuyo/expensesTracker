import 'package:expensestracker/Data/data_provider.dart';
import 'package:expensestracker/models/Records.dart';
import 'package:expensestracker/models/usersModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../main.dart';
import 'category.dart';

class createRecord extends StatefulWidget {
  final UserModel currentUsers;
  const createRecord(this.currentUsers);
  @override
  State<StatefulWidget> createState() => _createRecordState();
}

class _createRecordState extends State<createRecord> {
  final TextEditingController _categoryController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
   int _recordTypeController = 0;
  int categoryId;

  List<bool> isSelected = [true, false];
  FocusNode focusIncome = FocusNode();
  FocusNode focusExpenses = FocusNode();
  List<FocusNode> focusToggle;
  String month = "";
  var _savedDate, _savedTime;
  @override
  void initState() {
    super.initState();
    focusToggle = [focusIncome, focusExpenses];
    _categoryController.text = "Food & Drinks";
    categoryId = 1;
    _savedDate = DateTime.now();
    _savedDate = DateTime.now();
    switch (DateTime.now().month.toInt()) {
      case 1:
        {
          month = "Jan";
          print(month);
        }
        break;

      case 2:
        {
          month = "Feb";
          print(month);
        }
        break;
      case 3:
        {
          month = "Mar";
          print(month);
        }
        break;
      case 4:
        {
          month = "Apr";
          print(month);
        }
        break;
      case 5:
        {
          month = "May";
          print(month);
        }
        break;
      case 6:
        {
          month = "Jun";
          print(month);
        }
        break;
      case 7:
        {
          month = "July";
          print(month);
        }
        break;
      case 8:
        {
          month = "Aug";
          print(month);
        }
        break;
      case 9:
        {
          month = "Sep";
          print(month);
        }
        break;
      case 10:
        {
          month = "Oct";
          print(month);
        }
        break;
      case 11:
        {
          month = "Nov";
          print(month);
        }
        break;

      default:
        {
          month = "Dec";
          print(month);
        }
        break;
    }
    _dateController.text = month +
        "-" +
        DateTime.now().day.toString() +
        "-" +
        DateTime.now().year.toString();
    _timeController.text =
        DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString();

  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusIncome.dispose();
    focusExpenses.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context, true),
        ),
        backgroundColor: Colors.teal,
        title: Text(
          "Add Record",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _addRecord();
            },
          ),
        ],
      ),
      body: new Form(
        key: _formKey,
        child: Center(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: <Widget>[
                    ToggleButtons(
                      color: Colors.black,
                      selectedColor: Colors.green,
                      // highlightColor: Colors.green,
                      borderColor: Colors.blueGrey,
                      borderWidth: 1,
                      disabledColor: Colors.blueGrey,
                      disabledBorderColor: Colors.blueGrey,
                      renderBorder: true,
                      focusColor: Colors.red,
                      focusNodes: focusToggle,
                      children: <Widget>[
                        SizedBox(
                          width: 150.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Income",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Expense",
                            ),
                          ),
                        )
                      ],
                      isSelected: isSelected,
                      onPressed: (int index) {
                        print("toggle index "+index.toString()+" is selected? "+ isSelected.toString());
                        if(index==0)
                        {
                          setState(() {
                            isSelected[0] = true;
                            isSelected[1] = false;
                            _recordTypeController = 0;
                            print("Controller "+_recordTypeController.toString());
                          });
                        }
                        if(index==1)
                        {
                          setState(() {
                            isSelected[0] = false;
                            isSelected[1] = true;
                            _recordTypeController = 1;
                            print("Controller "+_recordTypeController.toString());
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: 300.0,
                      child: TextFormField(
                        cursorColor: Colors.green,
                        maxLines: null,
                        minLines: 1,
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
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: 300.0,
                      child: TextFormField(
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
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: 300.0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
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
                                      _savedDate = date;
                                      _dateController.text = month+"-"+date.day.toString()+"-"+date.year.toString();
                                    },
                                    currentTime: DateTime.now(), locale: LocaleType.en);
                              },
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
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
                                  _savedTime = time;
                                    _timeController.text = time.hour.toString()+":"+time.minute.toString();
                                     print('confirm $time');
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: 300.0,
                      child: TextFormField(
                        controller: _categoryController,
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green, width: 2.0),
                            ),
                            labelText: "  Category"
                        ),
                        onTap: () async{

                          List result = await Navigator.push(context, MaterialPageRoute(builder: (context) => category(-1, "")),
                          );
                          setState(() {
                            _categoryController.text = result[0].toString();
                            categoryId = result[1];
                            print(result[1]);
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            )
        ),
      )
    );
  }

  void _addRecord() async {
    if (_formKey.currentState.validate()) {
      if (categoryId == null) {
        print("Category id: " + categoryId.toString());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                child: AlertDialog(
                  title: Text("Error Message"),
                  content: Text("No Category Selected"),
                  actions: [
                    FlatButton(
                      child: Text(
                        "Select",
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.redAccent),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              );
            });
      } else {
        final record = {
          "record": {
            "amount": _amountController.text,
            "notes": _notesController.text,
            "record_type": _recordTypeController,
            "date": new DateTime(_savedDate.year, _savedDate.month, _savedDate.day, _savedTime.hour, _savedTime.minute).toIso8601String(),
            "category_id": categoryId,
          }
        };
        print("Final date to be saved "+new DateTime(_savedDate.year, _savedDate.month, _savedDate.day, _savedTime.hour, _savedTime.minute).toIso8601String());
        dataProvider().token(widget.currentUsers.token);
        final response = await dataProvider().addRecord(record, widget.currentUsers);
        if (response.statusCode == 200) {
          print("Successfully save");
          Navigator.pop(context, true);
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  child: AlertDialog(
                    title: Text("Error Message"),
                    content: Text(response.body),
                    actions: [
                      FlatButton(
                        child: Text(
                          "Retry",
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.redAccent),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                );
              });
        }
      }
    }
  }
}
