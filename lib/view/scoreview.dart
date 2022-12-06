
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/provider/dataprovider.dart';
import 'package:providerapp/provider/userdetail.dart';

class MyScore extends StatefulWidget {
  const MyScore({super.key});

  @override
  State<MyScore> createState() => _MyScoreState();
}

class _MyScoreState extends State<MyScore> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  final postModel = Provider.of<UserDetail>(context, listen: false);
  // // postModel.getTotalScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Score"),
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
              child: Container(
                child: CircleAvatar(
                  radius: 100,
                  child:  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 68.0),
                      child: Column(
                        children: [
                          Text("Total Score", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                          Text("${value.getScore}",
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                        ],
                      ),
                    ),
                  )
                  
                )
                
               
              ),
            ),
          );
        }
      ),
    );
  }
}