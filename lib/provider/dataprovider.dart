
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:providerapp/model/apimodel.dart';
import 'package:providerapp/controller/fetchapiservice.dart';

class DataProvider extends ChangeNotifier {
  
  SmileyModel? post;
  bool loading = false;

  bool _isButtonDisabled = true;

  int _count = 0;

  late int realScore = 0;

  String _name = "";

  String _result = "No Result";

  int get count => _count;

 int get rScore  => realScore;

  String get resultCorrection => _result;

  bool get btnResult => _isButtonDisabled;

  String get names => _name;

  getPostData() async {
   loading = true;
    post = (await SmileyApi().getDatas());
   // print(post!.solution);
   loading = false;
    notifyListeners();
  }

  void increment() {
    _count++;
    _isButtonDisabled = false;
    notifyListeners();
  }

  int getData() {
    print("My Score is: $_count");
    return _count;
   // notifyListeners();
  }

  void resetData() {
    _count = 0;
    notifyListeners();
  }

  void resetButton() {
    _isButtonDisabled = true;
    notifyListeners();
  }

  void resetScore() {
    _count = 0;
    notifyListeners();
  }

  void resCorrect() {
    _result = "Correct";
    print(_result);
    notifyListeners();
  }


  void resIncorrect() {
    _result = "Incorrect";
    print(_result);
    notifyListeners();
  }

  void resetRes() {
    _result = "No Result";
    print(_result);
    notifyListeners();
  }


  Future<void>  getUserDetail() async {
  final user = FirebaseAuth.instance.currentUser;
  final uid1 = user!.uid;

  final getUser = FirebaseFirestore.instance.collection('users');

  DocumentSnapshot snapshot = await getUser.doc(uid1).get();
  var data1 = snapshot.data() as Map;
  
  _name = data1['Name'];
  notifyListeners();
  
  }

  Future<void> putScore() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid1 = user!.uid;
    final firestore = FirebaseFirestore.instance;
    
    // Get score data from the firestore
    DocumentSnapshot snapshot = await firestore.collection('scores').doc(uid1).get();
    var data1 = snapshot.data() as Map;
    int Scores = data1['Score'];
    
    // Check condition
    if (Scores == 0) {
      firestore.collection('scores').doc(uid1).set({
       "Name" : _name,
       "Score" : _count
  }
  );
    }
    else {
  realScore = _count + Scores;
  print("update score: $realScore");
    firestore.collection('scores').doc(uid1).set(
    {"Score" : realScore}
  );
    }
    
  notifyListeners();
  }

  // Update the score
//  Future<void> updateScore() async {
//   final user = FirebaseAuth.instance.currentUser;

//   final getUser = FirebaseFirestore.instance;

//   DataProvider dt = DataProvider();
//   int sc = dt.count;
  
//   final uid1 = user!.uid;
//   DocumentSnapshot snapshot = await getUser.collection('users').doc(uid1).get();
//   final data1 = snapshot.data() as Map;

//   int Scores = data1['Score'];
//   print("store data: $Scores");
//   realScore = sc + Scores;
//   print("update score: $realScore");
//     getUser.collection('scores').doc(uid1).set(
//     {"Score" : realScore}
//   );
  
//   notifyListeners();
//  }

 }


