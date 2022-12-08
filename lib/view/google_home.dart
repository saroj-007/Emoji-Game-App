
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/controller/google_sigin_service.dart';
import 'package:providerapp/provider/dataprovider.dart';
import 'package:providerapp/provider/userdetail.dart';
import 'package:providerapp/view/google_game_screen.dart';
import 'package:providerapp/view/google_profile.dart';
import 'package:providerapp/view/login.dart';

class GoogleHome extends StatefulWidget {
  const GoogleHome({super.key});

  @override
  State<GoogleHome> createState() => _GoogleHomeState();
}

class _GoogleHomeState extends State<GoogleHome> {

  GoogleService gp = GoogleService();

  @override
  void initState() {
    // TODO: implement initState
    final postModel = Provider.of<DataProvider>(context, listen: false);
    postModel.getPostData();
    postModel.startTimer();
    super.initState();
    final postModel1 = Provider.of<UserDetail>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Menu"),
        centerTitle: true,
        actions: [

          // for profile view
          InkWell(
            child: CircleAvatar(
                        radius: 21,
                        backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!,),  
                        backgroundColor: Colors.blueAccent,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const GoogleProfile()));
                      },
          ),

          // For logout
          IconButton(
            onPressed: () {
              gp.googleLogout();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const login()));
            }, 
            icon: Icon(Icons.logout)),          

        ],
      ),

      body: Center(
        child: ElevatedButton(
          child: const Text('START',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
           postModel.resetScore();
           postModel.resetRes();
           postModel.resetButton();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GoogleGame()));
          },
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(170, 170),
              shape: const CircleBorder(), 
          ),
),
      ),
    );
  }
}