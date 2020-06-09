import 'package:expensestracker/Data/data_provider.dart';
import 'package:expensestracker/models/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Registration extends StatefulWidget {
  Registration({Key key}) : super(key: key);
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  dataProvider get notesService => GetIt.I<dataProvider>();
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
                            height: 300.0,
                            width: 300.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Name",
                                  style: TextStyle(
                                      fontFamily: 'Nunito-Regular'
                                  ),),
                                TextFormField(
                                  controller: _nameController,
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
                                Text("Email",
                                  style: TextStyle(
                                      fontFamily: 'Nunito-Regular'
                                  ),),
                                TextFormField(
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
                                Text("Password",
                                  style: TextStyle(
                                      fontFamily: 'Nunito-Regular'
                                  ),),
                                TextFormField(
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
                                Text("Confirm password",
                                  style: TextStyle(
                                      fontFamily: 'Nunito-Regular'
                                  ),),
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText: true,
                                  validator: (value){
                                    if(value.isEmpty){
                                      return 'Password not match';
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
                              final user = User(
                                username: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text
                              );
                              final result = await dataProvider().addUser(user);
                              print(result.error);
                              print(result.errorMessage);
                              if(result.error)
                                {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text('Result'),
                                        content: Text(result.errorMessage),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      )
                                  );
                                }
                            },
                            child: new Text("SIGN UP",
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