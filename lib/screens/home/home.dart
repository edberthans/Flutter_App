import 'package:chat_flutter/models/chats.dart';
import 'package:chat_flutter/screens/home/chat_list.dart';
import 'package:chat_flutter/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_flutter/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: Text('bottom sheet'),
        );
      });
    }

    return StreamProvider<List<Chats>>.value(
      value: DatabaseService().chats,
          child: Scaffold(
        appBar: AppBar(
          title: Text('Chat Flutter'),
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text(
                'Logout'
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(), 
              icon: Icon(Icons.settings), 
              label: Text('Settings'),
            )
          ],
        ),
        body: ChatList(),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
