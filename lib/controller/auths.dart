
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:providerapp/view/homescreen.dart';
import 'package:providerapp/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices extends ChangeNotifier{

  // Login text editing controllers
  TextEditingController logEmails = TextEditingController();
  TextEditingController logPass = TextEditingController();

  // Registration text editing controllers
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

 // Firebase Auth instance
 final FirebaseAuth  _auth = FirebaseAuth.instance;

 // Firestore instance
 final firestore = FirebaseFirestore.instance;


 // For new user account
 Future<void> newAccount(context) async {
  
  try {
    final user = await _auth.createUserWithEmailAndPassword(
    email: emailController.text, 
    password: passController.text);

    DocumentSnapshot snapshot = await firestore.collection('users').doc(emailController.text).get();

    if (snapshot.exists) {
      Fluttertoast.showToast(msg: "User email already exists");
    }
    else {
      firestore.collection('users').doc(user.user!.uid).set({
    "Name" : userNameController.text,
    "Address" : addressController.text,
    "Mobile" : mobileController.text,
    "Email" : emailController.text,
    "Password" : passController.text
  }
  );
  Fluttertoast.showToast(msg: "Registration Successfully", fontSize: 20);
  Navigator.push(context, MaterialPageRoute(builder: (context) => const login()));
    }
  }
  on FirebaseAuthException catch(e) {
    Fluttertoast.showToast(msg: e.toString(),
    textColor: Colors.red
    );
  }
  
  
 }

 

 // For login method
 Future<void> loginUser(context) async {
  try {
    final user = await _auth.signInWithEmailAndPassword(
    email: logEmails.text, 
    password: logPass.text);

    if (user != null) {
     print("Login Successfully");
   Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));

   // Save user login with shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("userID", user.user!.uid);
    print("user id saved");
    print(prefs.getString("userID"));
  }
 
  } on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
    Fluttertoast.showToast(msg: "No user found for that email.", gravity: ToastGravity.CENTER,
                            textColor: Colors.redAccent, fontSize: 20.0);
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
    Fluttertoast.showToast(msg: "Wrong password provided for that user.", gravity: ToastGravity.CENTER,
                            textColor: Colors.redAccent,fontSize: 20.0);
  }
  }
  
 }

 // Function for logout user
 Future<void> logoutUser() async {
  await _auth.signOut();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  print("User logout Successfully");
 
  
 }

 // Function for autologin
 Future<bool> checkLoginStatus() async {
  var value = await SharedPreferences.getInstance();
  if (!value.containsKey("userID"))
  {
    return false;
  }
  else {
    return true;
  }
 }

  Future<void> googleLogin() async {
    print("Google Login Method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try{
      var res = await _googleSignIn.signIn();
      if (res == null) {
        return;
      }

      final userData = await res.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: userData.accessToken, idToken: userData.idToken
      );
      var finalResult = await FirebaseAuth.instance.signInWithCredential(credential);
      print("User detail");
      print(res.displayName);
      print(res.email);
      print(res.photoUrl);
      print(res.id);
    }
    catch(e) {

    }
  }

 

 }