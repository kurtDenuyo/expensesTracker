

import 'package:expensestracker/Data/data_provider.dart';
import 'package:expensestracker/models/successUsers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String errorMessage;

  @override
  void initState() {
    super.initState();


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
                                    decoration: InputDecoration(
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
                                  TextFormField(
                                    decoration: InputDecoration(
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
                                    final result = await dataProvider().loginUser(_emailController.text, _passwordController.text);
                                    print(result.body);
                                    print(result.statusCode);
                                    if(result.statusCode==200)
                                      {
                                        //on success navigate to dashboard
                                        print("Login success");
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),
                                        );
                                      }
                                    else
                                      {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context){
                                              return SizedBox(
                                                child: AlertDialog(
                                                  title: Text("Error Message"),
                                                  content: Text(result.body),
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