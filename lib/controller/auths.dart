
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


 // Function for new user account
 Future<void> newAccount(context) async {
  
  try {
    // Create authentication account with email and password
    final user = await _auth.createUserWithEmailAndPassword(
    email: emailController.text, 
    password: passController.text);
    
    // Get data from cloud firestore
    DocumentSnapshot snapshot = await firestore.collection('users').doc(emailController.text).get();
    
    // Check condition whether firestore contain user collection or not
    if (snapshot.exists) {
      Fluttertoast.showToast(msg: "User email already exists");
    }
    else {

      // if there is new user with new id then data store in collection
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

 

 // Function for login method login method
 Future<void> loginUser(context) async {
  // try catch block
  try {
    // login authentication with email and password provided by user
    final user = await _auth.signInWithEmailAndPassword(
    email: logEmails.text, 
    password: logPass.text);

    // Check if authentication contain valid user email with password
    if (user != null) {
     print("Login Successfully");
   Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));

   // Save user login email and password with help of shared preferences for future work
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Set respective user id after valid login credential
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
  // Authentication funcation for signout
  await _auth.signOut();

  // Get data which were stored in sharedpreferences after login
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  print("User logout Successfully");
 
  
 }

 }