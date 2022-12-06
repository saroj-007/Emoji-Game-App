
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/provider/userdetail.dart';
import 'package:providerapp/view/drawerscreen.dart';
import 'package:providerapp/view/homescreen.dart';
import 'package:providerapp/view/update_profile.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final postModel = Provider.of<UserDetail>(context, listen: false);
    postModel.getUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen()))
        ),
        title: Text("User Profile"),
        centerTitle: true,
      ),

      body: Consumer<UserDetail>(
        builder: (context, value, child) {
        return Container(
          height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x66fa8dc),
                  Color(0x996fa8dc),
                  Color(0xcc6fa8dc),
                  Color(0xff6fa8dc),
                ])
            ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                    child: CircleAvatar(
                      radius: 100,
                      child: Text(
                        (value.getName.isNotEmpty) ? value.getName[0].toUpperCase() : "",
                        
                        
                        style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold,
                      color: Colors.greenAccent),),
                    ),
                  ),
            
                  // Name 
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 12, bottom: 10),
                    child: Container(
                      child: Row(
                        children: [
                          const Text("Name:", 
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(value.getName,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
            
                  // Address
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 12, bottom: 10),
                    child: Container(
                      child: Row(
                        children: [
                          const Text("Address:", 
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(value.getAddress,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
            
                  // Email
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 12, bottom: 10),
                    child: Container(
                      child: Row(
                        children: [
                          const Text("Email:", 
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(value.getEmail,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
            
                  // Phone Number
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 12, bottom: 10),
                    child: Container(
                      child: Row(
                        children: [
                          const Text("Mobile:", 
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(value.getPhone,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          ),
                  
                        ],
                      ),
                    ),
                  ),
            
                  SizedBox(height: 33,),
            
                  // Edit profile button
                    SizedBox(
                    height: 60,
                      width: 360,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                 
                ),
                  onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateMyProfile(
                  )));
                        }, 
                        child: const Text('Edit Profile', 
                        style: TextStyle(
                          fontSize: 23, 
                          fontWeight: FontWeight.bold
                          ),
                          ), 
                        ),
                    )
                ],
              ),
            ),
          ),
        );
      },
      )
      
    );
  }
}