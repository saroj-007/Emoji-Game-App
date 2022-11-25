import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController emails = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Verify Email"),
      ),

      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 40),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: emails,
                            decoration: InputDecoration(
                              hintText: "Enter Email Address",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide()
                              )
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "Required this field";
                              }
                              return null;
                            },
                            
                          ),

                          const SizedBox(height: 35.0,),
                

                // Elevated Button
                SizedBox(
                height: 60,
                  width: 400,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
             
            ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()){
                        bool isValid = EmailValidator.validate(emails.text);

                        if (isValid) {
                          
                        }
                      }
                    }, 
                    child: const Text('Verify', 
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
      ),
      
                
      
    );
  }
}