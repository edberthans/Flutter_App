import 'package:chat_flutter/models/chats.dart';
import 'package:chat_flutter/screens/home/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {

    final chats = Provider.of<List<Chats>>(context) ?? [];
    // print(chats.documents);

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index){
        return ChatTile(chats: chats[index]);
      },
    );
  }
}