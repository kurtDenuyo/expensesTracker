import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class onBoarding extends StatefulWidget {
  onBoarding({Key key}) : super(key: key);
  @override
  _onBoardingState createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding>{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[200],
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 120.0,
              width: 450.0,
              child: Image.asset(
                "assets/images/app_icon.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("WALLET",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.green[800]
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("Track your spending.",
              style: TextStyle(
                fontFamily: 'Nunito',
                  fontSize: 16.0,
                 // fontWeight: FontWeight.bold,
                  color: Colors.black26,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("Plan your budget.",
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16.0,
                //fontWeight: FontWeight.bold,
                color: Colors.black26,
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            SizedBox(
              height: 60.0,
              width: 300.0,
              child: RaisedButton(
                padding: const EdgeInsets.all(8.0),
                color: Colors.white70,
                textColor: Colors.black,
                onPressed: (){

                },
                child: new Text("SIGN UP"),

              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            new InkWell(
              onTap: () {
              },
              child: new Text("I alrady have an account.",
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16.0,
                  //fontWeight: FontWeight.bold,
                  color: Colors.black26,
                ),
              ),
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}