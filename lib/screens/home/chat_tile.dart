import 'package:chat_flutter/models/chats.dart';
import 'package:flutter/material.dart';
import 'chat_list.dart';

class ChatTile extends StatelessWidget {

  final Chats chats;
  ChatTile({this.chats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top:8,
      ),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
          ),
          title: Text(chats.name),
          subtitle: Text('Chat: ${chats.datebirth}'),
        ),
      ),
    );
  }
}