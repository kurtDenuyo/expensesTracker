import 'package:expensestracker/views/onBoarding.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: <Widget>[
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NO"),
            ),
            SizedBox(height: 16),
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Text("YES"),
            ),
          ],
        ),
      ) ??
          false;
    }
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: new Scaffold(
          body: onBoarding(),
        ),
      ),
    );
  }

}
