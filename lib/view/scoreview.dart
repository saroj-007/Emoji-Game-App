
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/controller/userdetail.dart';

class MyScore extends StatefulWidget {
  const MyScore({super.key});

  @override
  State<MyScore> createState() => _MyScoreState();
}

class _MyScoreState extends State<MyScore> {
  
  // int level = 0;

  // void levelGrow() {
  //   final postModel = Provider.of<UserDetail>(context, listen: false);
  //   int scores = postModel.getScore;

  //   if (scores == 0 || scores <= 15) {
  //     level = 1;
  //   }
  //   else if (scores > 15 || scores <= 30) {
  //     level = 2;
  //   }
  //   else if (scores > 30 || scores <= 45) {
  //     level = 3;
  //   }
  //   else {
  //     level = 4;
  //   }
  // }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final postModel = Provider.of<UserDetail>(context, listen: false);
  // // postModel.getTotalScore();
    postModel.levelGrow();
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
            decoration: const BoxDecoration(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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

                          // Level score text
                          Text("Level: ${value.getLevel}", 
                          style: const TextStyle(
                            fontSize: 20,
                            
                          ),)
                            ],

                          ),
                        ),
                      )
                      
                    ),
                    
                    // Reset button to delete score
                   
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(200 , 60),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
                ),
               onPressed: () async {
                value.deleteScore();
                value.getTotalScore();
               // value.levelGrow();
               // final postModel = Provider.of<UserDetail>(context, listen: false);
               }, 
                icon: const FaIcon(FontAwesomeIcons.arrowDownLong, color: Colors.red,), 
                label: const Text('Reset',
                style: TextStyle(
                    fontSize: 23, 
                    fontWeight: FontWeight.bold
                    ),),
                ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}