
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:providerapp/provider/dataprovider.dart';

class UserDetail extends ChangeNotifier{

  final user = FirebaseAuth.instance.currentUser;

  final getUser = FirebaseFirestore.instance;
  

  String Name = "";
  String Address = "";
  String Email = "";
  String Phone = "";
  String Password = "";

  int Scores = 0;

  int get getScore => Scores;

  String get getName => Name;
  String get getAddress => Address;
  String get getEmail => Email;
  String get getPhone => Phone;
  String get getPassword => Password;

  // Get User detail
 Future<void>  getUserDetail() async {

  final uid1 = user!.uid;

  DocumentSnapshot snapshot = await getUser.collection('users').doc(uid1).get();
  var data1 = snapshot.data() as Map;

  Name = data1['Name'];
  Address = data1['Address'];
  Email = data1['Email'];
  Password = data1['Password'];
  Phone = data1['Mobile'];
  
  notifyListeners();
 }
 
 
 Future<void>  getTotalScore() async {
  
  final uid1 = user!.uid;
  DocumentSnapshot snapshot = await getUser.collection('scores').doc(uid1).get();

  var data1 = snapshot.data() as Map;
  Scores = data1['Score'];
  notifyListeners();
 }

 
}