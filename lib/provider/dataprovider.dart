
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:providerapp/model/apimodel.dart';
import 'package:providerapp/controller/fetchapiservice.dart';

class DataProvider extends ChangeNotifier {

  late Timer _timer;
  String secondString = '00';
  int seconds = 0;
  
  SmileyModel? post;
  bool loading = false;

  bool _isButtonDisabled = true;

  bool showResult = false;

  int _count = 0;

  late int realScore = 0;

  String _name = "";

  String _result = "No Result";

  int get count => _count;

  bool get solResult => showResult;

 int get rScore  => realScore;

  String get resultCorrection => _result;

  bool get btnResult => _isButtonDisabled;

  String get names => _name;

  String get seondsResult => secondString;

  int get secondTimer => seconds;

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

  void timerResultReset() {
    showResult = false;
    notifyListeners();
  }

  // timer function part
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) { 
    startSecond();

    if (seconds == 30) {
     _timer.cancel();
     showResult = true;
    }

    });
   // notifyListeners();
  }

  // Pause time function
  void pauseTimer() {
    _timer.cancel();
    notifyListeners();
  }

// Reset timer function
void resetTimer() {
  _timer.cancel();
  seconds = 0;
  secondString = "0";
  notifyListeners();
}

  // Increase timer
  void startSecond() {
    seconds ++;
    secondString = seconds.toString();
    if (secondString.length == 1){
      secondString = "0" + secondString;
    }
    notifyListeners();
  }

  // Get user detail part
  // User detail function
  Future<void>  getUserDetail() async {
  final user = FirebaseAuth.instance.currentUser;
  final uid1 = user!.uid;

  final getUser = FirebaseFirestore.instance.collection('users');

  DocumentSnapshot snapshot = await getUser.doc(uid1).get();
  var data1 = snapshot.data() as Map;
  
  _name = data1['Name'];
  notifyListeners();
  
  }

  // Function to store score
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


