import 'package:chat_flutter/screens/authenticate/register.dart';
import 'package:chat_flutter/services/auth.dart';
import 'package:chat_flutter/screens/authenticate/authenticate.dart';
import 'package:chat_flutter/shared/constants.dart';
import 'package:chat_flutter/shared/globals.dart';
import 'package:chat_flutter/shared/loading.dart';
import 'package:chat_flutter/widgets/wave_widget.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        title: Center(
          child: Text('Sign In')
        )
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                        loading= true;
                      });
                      dynamic result = await _auth.signIn(email, password);
                      if (result == null){
                        setState(() {
                          loading = false;
                          error = 'User not registered';
                        });
                      }
                      else{
                        print(result);
                      }
                    }
                  },
                  color: Colors.teal,
                  child: Text(
                    'Email Sign In',
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
                    'Don''t ' 'Have An Account?',
                    style: TextStyle(
                      color: Colors.purpleAccent,
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}