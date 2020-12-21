import 'package:chat_flutter/profile/profile_form.dart';
import 'package:chat_flutter/screens/authenticate/sign_in.dart';
import 'package:chat_flutter/screens/authenticate/authenticate.dart';
import 'package:chat_flutter/services/auth.dart';
import 'package:chat_flutter/shared/constants.dart';
import 'package:chat_flutter/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        title: Center(
          child: Text('Register')
        )
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              Icon(
                Icons.mail,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (emailval) {
                  setState(() {
                    email = emailval;
                  });
                },
              ),
              
              SizedBox(
                height: 12
              ),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 20),
              Icon(
                Icons.vpn_key,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Password contains more than 6 characters' : null,
                onChanged: (passwordval) {
                  password = passwordval;
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.register(email, password);
                    if (result == null){
                      setState(() {
                        loading = false;
                        error = 'Please enter valid email';
                      });
                    }
                    else{
                      print(result);
                    }
                  }
                },
                color: Colors.teal,
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.purpleAccent,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  widget.toggleView();
                },
                color: Colors.blueGrey,
                child: Text(
                  'Have an Account?',
                  style: TextStyle(
                    color: Colors.purpleAccent,
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}