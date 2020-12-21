import 'package:chat_flutter/models/user.dart';
import 'package:chat_flutter/screens/home/home.dart';
import 'package:chat_flutter/services/auth.dart';
import 'package:chat_flutter/services/database.dart';
import 'package:chat_flutter/shared/constants.dart';
import 'package:chat_flutter/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

enum Gender { male, female }

class _ProfileFormState extends State<ProfileForm> {
  final AuthService _auth = AuthService();
  String _name;
  String gender = 'male';
  int level = 0;
  Gender _character = Gender.male;

  @override
  Widget build(BuildContext context) {

  final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData){

          UserData userdata = snapshot.data;
          
          return Scaffold(
            backgroundColor: Colors.amber[50],
            appBar: AppBar(
              // image: Image(image: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg'),)
              title: Text('Chat Flutter'),
              centerTitle: true,
              backgroundColor: Colors.cyanAccent[700],
              elevation: 0,
                actions: [
                  FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text(
                      'Logout'
                    ),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  )
                ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await DatabaseService(uid: user.uid).updateUserData(
                  _name,
                  '',
                  '',
                  '',
                  gender,
                );
              },
              child: Icon(Icons.navigate_next),
              backgroundColor: Colors.pink,
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/1.jpg'),
                      radius: 40,
                    ),
                  ),
                  Divider(
                    height: 60,
                    color: Colors.cyanAccent[700],
                  ),
                  Text(
                    'Name',
                    style: TextStyle(
                      color: Colors.purple,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: formInputDecoration.copyWith(hintText: 'Full Name'),
                    onChanged: (nameval) {
                      _name = nameval;
                    },
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Gender',
                    style: TextStyle(
                      color: Colors.purple,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Column(
                    children: [
                      ListTile(
                        title: const Text('male'),
                        leading: Radio(
                          value: Gender.male,
                          groupValue: _character,
                          onChanged: (Gender value) {
                            setState(() {
                              _character = value;
                              gender = 'male';
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('female'),
                        leading: Radio(
                          value: Gender.female,
                          groupValue: _character,
                          onChanged: (Gender value) {
                            setState(() {
                              _character = value;
                              gender = 'female';
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
              // RaisedButton(
              //   onPressed: () async {
              //     await DatabaseService(uid: user.uid).updateUserData(
              //       _name ?? userdata.name,
              //       '',
              //       '',
              //       '',
              //       _character ?? userdata.gender,
              //     );
              //     print(_character);
              //     return Home();
              //   },
              //   color: Colors.teal,
              //   child: Text(
              //     'Update',
              //     style: TextStyle(
              //       color: Colors.purpleAccent,
              //     ),
              //   ),
              // ),
                    ],
                  ),
                  // Text(
                  //   '$level',
                  //   style: TextStyle(
                  //     color: Colors.deepOrange,
                  //     letterSpacing: 2,
                  //     fontSize: 28,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(height: 30,),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.email,
                  //       color: Colors.grey,
                  //     ),
                  //     SizedBox(width: 10,),
                  //     Text(
                  //       'hans@gmail.com',
                  //       style: TextStyle(
                  //         color: Colors.brown,
                  //         fontSize: 18,
                  //         letterSpacing: 2,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          );
        }
        else{
          return Loading();
        }
      }
    );

  }
}