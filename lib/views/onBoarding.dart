import 'package:expensestracker/views/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loginPage.dart';

class onBoarding extends StatefulWidget {
  onBoarding({Key key}) : super(key: key);
  @override
  _onBoardingState createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding>{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[100],
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60.0,
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
              fontFamily: 'Nunito-ExtraBold',
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.green[600]
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("Track your spending.",
              style: TextStyle(
                fontFamily: 'Nunito-Regular',
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
                fontFamily: 'Nunito-Regular',
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Registration()),
                  );
                },
                child: new Text("SIGN UP",
                style: TextStyle(
                  fontFamily: 'Nunito-Bold',
                  fontSize: 20.0
                ),),

              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            new InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: new Text("I alreadyy have an account.",
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