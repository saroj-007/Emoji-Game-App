
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyGoogleSignIn extends StatelessWidget {
  const MyGoogleSignIn({super.key});

  googleLogin() async {
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

  @override
  Widget build(BuildContext context) {
    return Material(
    child: Container(
      child: Center(
        child: ElevatedButton(
          onPressed: googleLogin(), 
          child: Text("Google Sign In")
          ),
      ),
    )
    );
  }
}