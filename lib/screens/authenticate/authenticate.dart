import 'package:chat_flutter/screens/authenticate/register.dart';
import 'package:chat_flutter/screens/authenticate/sign_in.dart';
import 'package:chat_flutter/screens/authenticate/login_view.dart';
import 'package:chat_flutter/viewmodels/home_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginView(),
      ),
    );
  }
}

// class _AuthenticateState extends State<Authenticate> {

//   bool showSignIn = true;
//   void toggleView(){
//     setState(() => showSignIn = !showSignIn );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showSignIn) {
//       return SignIn(toggleView: toggleView);
//     }
//     else{
//       return Register(toggleView: toggleView);
//     }
//   }
// }
