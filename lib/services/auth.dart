import 'package:chat_flutter/models/user.dart';
import 'package:chat_flutter/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class AuthService {

  //create user obj based on FirebaseUser (User)
  User _usersFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //get currentUser logged in
  Future getUserLoggedIn() async {
    try{
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      return _usersFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
    }
    
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      // .map((FirebaseUser user) => _usersFromFirebaseUser(user));
      .map(_usersFromFirebaseUser);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in with email and password
  Future signIn(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _usersFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future register(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // //create a document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('', '', '', '', '', false, '');

      return _usersFromFirebaseUser(user);

    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}