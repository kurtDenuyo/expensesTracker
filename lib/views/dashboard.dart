

import 'package:expensestracker/Data/data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'createRecord.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
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
          body: Container(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => createRecord()),
                        );
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => createRecord()),
              );
            },
            child: Icon(Icons.add),
          ), //
        ),
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