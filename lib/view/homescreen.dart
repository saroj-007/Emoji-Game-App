
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/controller/dataprovider.dart';
import 'package:providerapp/view/drawerscreen.dart';
import 'package:providerapp/view/gamescreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final postModel = Provider.of<DataProvider>(context, listen: false);
    postModel.getPostData();
    postModel.getUserDetail();
  // postModel.startTimer();
    
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Menu"),
        centerTitle: true,
      ),

      body: Center(
        child: ElevatedButton(
          child: const Text('START',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
           // postModel.count;
           postModel.resetScore();
           postModel.resetRes();
           postModel.resetButton();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GameScreen()));
          },
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(170, 170),
              shape: const CircleBorder(), 
          ),
),
      ),
      
      drawer: DrawerScreen(),
    );
  }
}