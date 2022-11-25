
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/provider/userdetail.dart';

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
        title: Text("User Profile"),
        centerTitle: true,
      ),

      body: Consumer<UserDetail>(
        builder: (context, value, child) {
        return Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                child: CircleAvatar(
                  radius: 100,
                  child: Text(value.getName[0], style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold,
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

            ],
          ),
        );
      },
      )
      
    );
  }
}