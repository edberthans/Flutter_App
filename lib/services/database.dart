import 'package:chat_flutter/models/chats.dart';
import 'package:chat_flutter/models/femaleList.dart';
import 'package:chat_flutter/models/user.dart';
import 'package:chat_flutter/shared/imageCapture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference chatCollection = Firestore.instance.collection('user');
  final CollectionReference femaleCollection = Firestore.instance.collection('female');

  Future updateUserData(String name, String picture, String phone, String datebirth, String gender) async {
    return await chatCollection.document(uid).setData({
      'name': name,
      'picture': picture,
      'phone': phone,
      'datebirth': datebirth,
      'gender': gender,
    });
  }

  Future updateFemaleData(String name, String picture, String phone, int rating, String datebirth, String gender) async {
    return await femaleCollection.document(uid).setData({
      'femaleName': name,
      'femaleimage': picture,
      'phone': phone,
      'rating': rating,
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

  //female list from snapshots
  List<femaleList> _femaleListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) => femaleList(
      femaleimage: doc.data['femaleimage'] ?? '',
      femaleName: doc.data['femaleName'] ?? '',
      dateofbirth: doc.data['dateofbirth'] ?? '',
      rating: doc.data['rating'] ?? '',
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

  //get female list
  Stream<List<femaleList>> get female {
    return chatCollection.snapshots()
      .map(_femaleListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData{
    return chatCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}