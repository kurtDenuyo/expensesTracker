

import 'dart:convert';

import 'package:expensestracker/Data/data_provider.dart';
import 'package:expensestracker/models/usersModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  final String email, password;
  const LoginPage(this.email, this.password);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   TextEditingController _emailController = TextEditingController();
   TextEditingController _passwordController = TextEditingController();

  final storage = new FlutterSecureStorage();
  var email;
  var pass;
  String errorMessage;

  @override
  void initState(){
    super.initState();
    getCurrentlyLoggedUser();
  }
  void getCurrentlyLoggedUser() async{
    if(widget.email!="")
    {
      _emailController.text = widget.email;
      _passwordController.text = widget.password;
      final response = await dataProvider().loginUser(_emailController.text, _passwordController.text);
      if(response.statusCode == 200)
      {
        final result = userModelFromJson(response.body);
        //on success navigate to dashboard
        print("Login success with username"+result.user.email);
         Navigator.push(context, MaterialPageRoute(builder: (context) => Home(result)),);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green[100],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.green[800]),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                  color: Colors.green[100],
                  child: Container(
                    color: Colors.green[100],
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
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
                            height: 30.0,
                          ),
                          SizedBox(
                              height: 400.0,
                              width: 300.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                      ),
                                      labelText: "Email",
                                    ),
                                    controller: _emailController,
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
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    cursorColor: Colors.green,
                                    decoration: InputDecoration(
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.green, width: 2.0),
                                      ),
                                      labelText: "Password",
                                    ),
                                    controller: _passwordController,
                                    obscureText: true,
                                    validator: (value){
                                      if(value.isEmpty){
                                        return 'Please enter a password';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        fontFamily: 'Nunito-Regular'
                                    ),
                                  ),
                                ],
                              )
                          ),
                          SizedBox(
                            height: 50.0,
                            width: 300.0,
                            child: RaisedButton(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.white70,
                              textColor: Colors.black,
                              onPressed: () async{
                                if(_formKey.currentState.validate())
                                  {
                                    final response = await dataProvider().loginUser(_emailController.text, _passwordController.text);
                                    if(response.statusCode == 200)
                                    {
                                      final result = userModelFromJson(response.body);
                                      //on success navigate to dashboard
                                      await storage.write(key: "email", value: _emailController.text);
                                       await storage.write(key: "password", value: _passwordController.text);
                                      print("Login success with token "+result.token);
                                       Navigator.push(context, MaterialPageRoute(builder: (context) => Home(result)),);
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
                              },
                              child: new Text("SIGN IN",
                                style: TextStyle(
                                    fontFamily: 'Nunito-Bold',
                                    fontSize: 20.0
                                ),),

                            ),
                          ),
                          SizedBox(
                            height: 120.0,
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        )
    );
  }
}