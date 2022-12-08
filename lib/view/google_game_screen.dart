import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/controller/auths.dart';
import 'package:providerapp/controller/dataprovider.dart';
import 'package:providerapp/view/google_home.dart';

class GoogleGame extends StatefulWidget {
  const GoogleGame({super.key});

  @override
  State<GoogleGame> createState() => _GoogleGameState();
}

class _GoogleGameState extends State<GoogleGame> {

  final TextEditingController user1 = TextEditingController();

 String _resultCheck = "No Result";
 String res = "";

 int score = 0;
 int tries = 0;

  
 late int _selectedNums = 0;
  
  List<int> nums = [0,1,2,3,4,5,6,7,8,9];

AuthServices au = AuthServices();

  @override
  Widget build(BuildContext context) {
   // final scoreModel = Provider.of<UserDetail>(context, listen: false);
     return Consumer<DataProvider>(
       builder: (context, providerValue, child) {
         return Scaffold(
          appBar: AppBar(
            title: Text("Game Screen"),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
             body: Padding(
               padding: const EdgeInsets.only(top:30),
               child: Container(
                // color: Colors.blueAccent,
                 height: 900,
                 width: 400,
               
                 child: Column(
                   children: [
                     Container(
                       
                     child: Image(image: NetworkImage(providerValue.post!.question.toString())),
                     ),
                     
                     const SizedBox(height: 15,),
                     Padding(
                       padding: const EdgeInsets.only(top: 45),
                       child: Container(
                         
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   
                                 // Drop Down menu
                                 Padding(
                                   padding: const EdgeInsets.only(left: 35),
                                   child: SizedBox(
                                     height: 60,
                                     width: 70,
                                     child: DropdownButtonFormField<int>(
                                           icon: Icon(Icons.arrow_downward),
                                           iconSize: 24,
                                           elevation: 16,
                                           isExpanded: true,
                                           style: TextStyle(color: Colors.blueAccent, fontSize: 20),
         
                                     decoration: InputDecoration(
                                                 enabledBorder: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(12),
                                                 borderSide: const BorderSide(width: 3, color: Colors.blueAccent)
                                    )
                                  ),
                                     items: nums.map((int dropDownValue) {
                                  return DropdownMenuItem<int>(
                                   value: dropDownValue,
              
                                   child: Text(dropDownValue.toString())
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _selectedNums = newVal!;
              print(_selectedNums);
            }
            
            );
          },
          value: _selectedNums,
          
          ),
                                   ),
                                 ),
  
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: ElevatedButton(
                             
                             onPressed: (){
                             var res1 = providerValue.post!.solution;

                             bool resButton = providerValue.btnResult;
                           //  print(resButton);

                               // To check condition for the correct answer

                              if (resButton) {
                              if (providerValue.secondTimer < 30) {
                              if ( res1 == _selectedNums){
                               providerValue.increment();
                               providerValue.getData();
                               providerValue.resCorrect();
                               providerValue.pauseTimer();
                              // providerValue.getPostData();
                              // providerValue.resetRes();
                               // providerValue.resetScore();
                              // providerValue.resetButton();
                             }
                             else{
                               providerValue.resIncorrect();
                               tries += 1;
                               print("Try: $tries");
                             }
                                  }

                              else if (providerValue.secondTimer == 30){
                                Fluttertoast.showToast(msg: "Timed Out", textColor: Colors.red);
                              }         
                               }               
                         }, 
                       child:  const Text("Submit",
                       ),
                       style: ElevatedButton.styleFrom(
                        backgroundColor: providerValue.btnResult ? Colors.blue : Colors.red
                       ),),
                          ),
           
                     //  const SizedBox(height: 15,),

                       Padding(
                         padding: const EdgeInsets.only(left: 13.0),
                         child: ElevatedButton(
                         onPressed: () {
                           providerValue.getPostData();
                           providerValue.resetRes();
                           providerValue.resetButton();
                          providerValue.resetTimer();
                          providerValue.timerResultReset();
                          providerValue.startTimer();
                          _selectedNums = 0;
                         }, 
                         child: const Text("New Game")),
                       ),

                       Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ElevatedButton(onPressed: (){
               providerValue.storeScore();
               providerValue.resetTimer();
               providerValue.timerResultReset();
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => GoogleHome()));
             }, child: const Text("Quit")),
                     ),
                                 ],
                               ),
                       ),
                     ),
                    const SizedBox(
                     height: 20,
                    ), 
                    
                     Row(
                       children: [

                         Padding(
                 padding: const EdgeInsets.only(left:35.0),
                 child: Text("${providerValue.resultCorrection}", 
                 style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                 ),
               ),

                         Padding(
                 padding: const EdgeInsets.only(left:50.0),
                 child: Text(providerValue.solResult ?
                  "Hint: ${providerValue.post!.solution}" : ""
                  , style: const TextStyle(fontSize: 20),),
               ),

               Padding(
                 padding: const EdgeInsets.only(left:50.0),
                 child: Text("Score: ${providerValue.count}", style: const TextStyle(fontSize: 20),),
               ),
                       ],
                     ),

                      SizedBox(height: 30,),
                     // Timer Screen
                     Container(
                      child: Text(providerValue.secondString,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                     )

                   ],
                 ),    
               ),
             ),
           );
       },  
       
     );
  }
}