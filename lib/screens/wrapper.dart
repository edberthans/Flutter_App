import 'package:chat_flutter/models/user.dart';
import 'package:chat_flutter/profile/profile_form.dart';
import 'package:chat_flutter/screens/authenticate/authenticate.dart';
import 'package:chat_flutter/screens/home/home.dart';
import 'package:chat_flutter/screens/home/home_page.dart';
import 'package:chat_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null){
      return Authenticate();
    }
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){

        UserData userdata = snapshot.data;

        // return either home or authenticate widget
        if (userdata == null){
          return Authenticate();
        }
        // user hasnt registered name and gender
        else if (userdata.name == '' || userdata.gender == ''){
          return ProfileForm();
        }
        // return Home();
        else {
          return HomePage();
        }
        
          }
        );

    
  }
}
