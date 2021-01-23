import 'package:chat_flutter/models/chats.dart';
import 'package:chat_flutter/models/jasaList.dart';
import 'package:chat_flutter/models/jasaUser.dart';
import 'package:chat_flutter/models/user.dart';
import 'package:chat_flutter/shared/imageCapture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference chatCollection = Firestore.instance.collection('user');
  final CollectionReference jasaCollection = Firestore.instance.collection('jasa');

  Future updateUserData(String name, String picture, String phone, String datebirth, String gender, bool verifiedDocument, String docUrl) async {
    return await chatCollection.document(uid).setData({
      'name': name,
      'picture': picture,
      'phone': phone,
      'datebirth': datebirth,
      'gender': gender,
      'verifiedDocument' : verifiedDocument,
      'docUrl' : docUrl,

    });
  }

  Future updateJasaData(String gender, List<String> pictures, String description, String notes, String languages, int height, List<String> preferences) async {
    return await jasaCollection.document(uid).setData({
      'jasaGender': gender,
      'jasaPictures': pictures,
      'jasaDescription': description,
      'jasaNotes': notes,
      'jasaLanguages': languages,
      'jasaHeight': height,
      'jasaPreferences': preferences
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

  //jasa list from snapshots
  List<JasaList> _jasaListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) => JasaList(
      gender: doc.data['jasaGender'] ?? '',
      pictures: doc.data['jasaPictures'] ?? '',
      description: doc.data['jasaDescription'] ?? '',
      notes: doc.data['jasaNotes'] ?? '',
      languages: doc.data['jasaLanguanges'] ?? '',
      height: doc.data['jasaHeight'] ?? 0,
      preferences: doc.data['jasaPreferences'] ?? '',
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
      verifiedDocument: snapshot.data['verifiedDocument'],
      docUrl: snapshot.data['docUrl'] ?? '',
    );
  }

  //jasa user data from snapshot
  JasaUserData _jasauserDataFromSnapshot(DocumentSnapshot snapshot){
    return JasaUserData(
      gender: snapshot.data['jasaGender'] ?? '',
      pictures: snapshot.data['jasaPictures'] ?? '',
      description: snapshot.data['jasaDescription'] ?? '',
      notes: snapshot.data['jasaNotes'] ?? '',
      languages: snapshot.data['jasaLanguanges'] ?? '',
      height: snapshot.data['jasaHeight'] ?? 0,
      preferences: snapshot.data['jasaPreferences'] ?? '',
    );
  }

  //get user chat
  Stream<List<Chats>> get chats {
    return chatCollection.snapshots()
      .map(_chatsListFromSnapshot);
  }

  //get jasa list
  Stream<List<JasaList>> get jasaLists {
    return jasaCollection.snapshots()
      .map(_jasaListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData{
    return chatCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

  //get jasa user doc stream
  Stream<JasaUserData> get jasauserData{
    return chatCollection.document(uid).snapshots()
      .map(_jasauserDataFromSnapshot);
  }

}