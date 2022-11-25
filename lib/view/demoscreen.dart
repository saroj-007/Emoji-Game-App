import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/provider/dataprovider.dart';

class ProviderDemoScreen extends StatefulWidget {
  const ProviderDemoScreen({super.key});

  @override
  State<ProviderDemoScreen> createState() => _ProviderDemoScreenState();
}

class _ProviderDemoScreenState extends State<ProviderDemoScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
 //  final postModel = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("API"),),
      body: Center(
        child: Consumer<DataProvider> (
          builder: (context, value, child) {
            return Column(
              children: [
                Image(image: NetworkImage(value.post!.question.toString())),
                Text(
                "Provider Value ${value.post!.solution}",
              //  "Ppriver",
                  style: TextStyle(fontSize: 25),
                ),
                ElevatedButton(onPressed: (){
                  value.getPostData();
                }, child: Text("Check")),
                
                
              ],
            );
          },
        ),
      ) 
    );
  }
}