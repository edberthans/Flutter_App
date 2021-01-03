import 'package:chat_flutter/models/user.dart';
import 'package:chat_flutter/screens/home/home.dart';
import 'package:chat_flutter/screens/home/home_page.dart';
import 'package:chat_flutter/services/auth.dart';
import 'package:chat_flutter/services/database.dart';
import 'package:chat_flutter/shared/constants.dart';
import 'package:chat_flutter/shared/imageCapture.dart';
import 'package:chat_flutter/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  UserData userdata;
  String pic;
  DateTime datetime;
  String isoDate;
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String formattedDate;

  @override
  Widget build(BuildContext context) {

  final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          userdata = snapshot.data;
          if(userdata.datebirth != ''){
            datetime = DateTime.parse(userdata.datebirth);
            formattedDate = formatter.format(datetime);
          }
         
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.amber[50],
            appBar: AppBar(
              // image: Image(image: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg'),)
              title: Text('Kencan'),
              centerTitle: true,
              backgroundColor: Colors.cyanAccent[700],
              elevation: 0,
                actions: [
                  // FlatButton.icon(
                  //   icon: Icon(Icons.person),
                  //   label: Text(
                  //     'Logout'
                  //   ),
                  //   onPressed: () async {
                  //     await _auth.signOut();
                  //   },
                  // )
                ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await DatabaseService(uid: user.uid).updateUserData(
                  _name ?? userdata.name,
                  userdata.picture,
                  '',
                  isoDate ?? userdata.datebirth,
                  gender,
                );
                return HomePage();
              },
              child: Icon(Icons.navigate_next),
              backgroundColor: Colors.pink,
            ),
            body: SingleChildScrollView(
                          child: Padding(
                padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ImageCapture()),
                          );
                        },
                        child: CircleAvatar(
                          // backgroundImage: AssetImage('assets/1.jpg'),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 7, 0, 0),
                            child: Text('Change Profile Picture',
                              style: TextStyle(
                                color: Colors.white30
                              ),
                            ),
                          ),
                          backgroundImage: NetworkImage(userdata.picture),
                          radius: 40,
                        ),
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
                      initialValue: userdata.name,
                      decoration: formInputDecoration.copyWith(hintText: 'Full Name'),
                      onChanged: (nameval) {
                        _name = nameval;
                      },
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Gender',
                      style: TextStyle(
                        color: Colors.purple,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      userdata.gender ?? gender,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Birth Date',
                      style: TextStyle(
                        color: Colors.purple,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      formattedDate == null ? '': formattedDate,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SingleChildScrollView(
                      child: RaisedButton(
                        child: Text('Pick a date'),
                        onPressed: () {
                          showDatePicker(context: context, initialDate: datetime ?? DateTime(2004), firstDate: DateTime(1960), lastDate: DateTime.now()).then((value) {
                            setState(() {
                              datetime = value;
                              isoDate = datetime.toIso8601String();
                            });
                          } );
                        },
                      ),
                    )
                  ],
                ),
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