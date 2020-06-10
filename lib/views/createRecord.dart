

import 'package:expensestracker/CustomDate/DatePicker.dart';
import 'package:expensestracker/CustomDate/src/i18n_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

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
    final TextEditingController _confirmPasswordController = TextEditingController();
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
        child: Center(
          child: SizedBox(
            height: 500.0,
            width: 300.0,
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
                  child: new TabBarView(

                    controller: _controller,
                    children: <Widget>[
                      new Card(
                          child: new ListView(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
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
                                decoration: InputDecoration(
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
                              TextFormField(
                                controller: _dateController,
                                decoration: InputDecoration(
                                    labelText: "  Date"
                                ),
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2000, 3, 5),
                                      maxTime: DateTime(2100, 6, 7), onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        //_dateController.text = date.toIso8601String();
                                        _dateController.text = date.toIso8601String();
                                        print('confirm $date');
                                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                                },
                              ),
                            ],
                          )
                      ),
                      new Card(
                        child: new ListTile(
                          leading: const Icon(Icons.location_on),
                          title: new Text('Latitude: 48.09342\nLongitude: 11.23403'),
                          trailing: new IconButton(icon: const Icon(Icons.my_location), onPressed: () {}),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}