
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/controller/google_sigin_service.dart';
import 'package:providerapp/controller/dataprovider.dart';


class GoogleProfile extends StatefulWidget {
  const GoogleProfile({super.key});

  @override
  State<GoogleProfile> createState() => _GoogleProfileState();
}

class _GoogleProfileState extends State<GoogleProfile> {

  GoogleService gp = GoogleService();

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        
        title:  Text("Profile"),
        centerTitle: true,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.top,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80, right: 80, left: 80, bottom: 20),
                child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!,),  
                          backgroundColor: Colors.blueAccent,
                        ),
              ),

              // Name from google
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 20, right: 20),
                child: Text("Name: ${FirebaseAuth.instance.currentUser!.displayName}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Email: ${FirebaseAuth.instance.currentUser!.email}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 20, right: 20),
                child: Text("Score: ${postModel.rScore}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}