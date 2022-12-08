
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:providerapp/controller/google_sigin_service.dart';
import 'package:providerapp/login.dart';

class GoogleProfile extends StatefulWidget {
  const GoogleProfile({super.key});

  @override
  State<GoogleProfile> createState() => _GoogleProfileState();
}

class _GoogleProfileState extends State<GoogleProfile> {

  GoogleService gp = GoogleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   TextButton(onPressed: () async {
        //     gp.googleLogout();
        //   }, 
        //   child: Text("logout"))
        // ],
        title:  Text("Profile"),
       // centerTitle: true,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(child: Image.network(FirebaseAuth.instance.currentUser!.photoURL!)),
              Text("Name: ${FirebaseAuth.instance.currentUser!.displayName}"),
              Text("Email: ${FirebaseAuth.instance.currentUser!.email}"),

              ElevatedButton(onPressed: () {
                gp.googleLogout();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const login()));
              }, child: Text("Logout"))
            ],
          ),
        ),
      ),
    );
  }
}