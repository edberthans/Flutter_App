import 'package:chat_flutter/models/chats.dart';
import 'package:chat_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference chatCollection = Firestore.instance.collection('user');

  Future updateUserData(String name, String picture, String phone, String datebirth, String gender) async {
    return await chatCollection.document(uid).setData({
      'name': name,
      'picture': picture,
      'phone': phone,
      'datebirth': datebirth,
      'gender': gender,
    });
  }

  //chats list from snapshots
  List<Chats> _chatsListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) => Chats(
      datebirth: doc.data['datebirth'] ?? '',
      phone: doc.data['phone'] ?? '',
      name: doc.data['name'] ?? '',
      picture: doc.data['picture'] ?? '',
      gender: doc.data['gender'] ?? '',
    )).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid:uid,
      datebirth: snapshot.data['datebirth'] ?? '',
      phone: snapshot.data['phone'] ?? '',
      name: snapshot.data['name'] ?? '',
      picture: snapshot.data['picture'] ?? '',
      gender: snapshot.data['gender'] ?? '',
    );
  }

  //get user chat
  Stream<List<Chats>> get chats {
    return chatCollection.snapshots()
      .map(_chatsListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData{
    return chatCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}