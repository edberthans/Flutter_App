import 'package:chat_flutter/models/user.dart';
import 'package:chat_flutter/profile/profile_form.dart';
import 'package:chat_flutter/services/auth.dart';
import 'package:chat_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  int level = 0;
  final AuthService _auth = AuthService();
  UserData userdata;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        userdata = snapshot.data;
        return Scaffold(
          backgroundColor: Colors.amber[50],
          appBar: AppBar(
            // image: Image(image: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg'),)
            title: Text('Kencan'),
            centerTitle: true,
            backgroundColor: Colors.cyanAccent[700],
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileForm()),
              );
            },
            child: Icon(Icons.edit),
            backgroundColor: Colors.pink,
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (userdata.picture != '') {
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userdata.picture),
                      radius: 40,
                    ),
                  ),
                // } else {
                //   Center(
                //     child: CircleAvatar(
                //       backgroundImage: AssetImage('assets/1.jpg'),
                //       radius: 40,
                //     ),
                //   ),
                // },
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
                Text(
                  userdata.name,
                  style: TextStyle(
                    color: Colors.deepOrange,
                    letterSpacing: 2,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
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
                Text(
                  userdata.gender,
                  style: TextStyle(
                    color: Colors.deepOrange,
                    letterSpacing: 2,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      'hans@gmail.com',
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 18,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );

  }
}