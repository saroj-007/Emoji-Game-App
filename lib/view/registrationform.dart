import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:providerapp/controller/auths.dart';
import 'package:providerapp/view/login.dart';


class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  final _formKey = GlobalKey<FormState>();

  AuthServices au = AuthServices();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const login()))
        ),
        centerTitle: true,
        title: const Text("Registration Form"),
      ),
      
      body: Container(
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
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
        
                  // Username 
                  Container(
                    child: TextFormField(
                      controller: au.userNameController,
                      decoration: InputDecoration(
                        hintText: "Enter User name",
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
                  ),
        
                  const SizedBox(height: 15.0,),
        
                  // Address 
                  Container(
                    child: TextFormField(
                      controller: au.addressController,
                      decoration: InputDecoration(
                        hintText: "Enter Your Address",
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
                  ),

                  const SizedBox(height: 15.0,),
        
                  // Mobile Number
                  Container(
                    child: TextFormField(
                      controller: au.mobileController,
                      decoration: InputDecoration(
                        hintText: "Enter Mobile Number",
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
                  ),
        
                  const SizedBox(height: 15.0,),
        
                  // Email
                  Container(
                    child: TextFormField(
                      controller: au.emailController,
                      decoration: InputDecoration(
                        hintText: "Enter Your Email Address",
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
                  ),
        
                  const SizedBox(height: 15.0,),

                  // Password Form 
                  Container(
                    child: TextFormField(
                      controller: au.passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
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
                  ),
        
                  const SizedBox(height: 15.0,),

                  // Confirm Password
                  Container(
                    child: TextFormField(
                      controller: au.confirmPassController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Confirm Password",
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
                  ),
        
                  const SizedBox(height: 15.0,),
                  

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
                          bool isValid = EmailValidator.validate(au.emailController.text);

                          if (isValid) {
                            if (au.passController.text == au.confirmPassController.text) {
                            au.newAccount(context);
                            }
                            else {
                              Fluttertoast.showToast(msg: "Password didnot match",
                              gravity: ToastGravity.CENTER,
                              textColor: Colors.redAccent,
                              fontSize: 20.0);
                            }
                          }
                          else {
                            Fluttertoast.showToast(
                              msg: "Invalid Email",
                              gravity: ToastGravity.CENTER,
                              textColor: Colors.redAccent,
                              fontSize: 20.0
                              );
                          }
                        }
                        
                      }, 
                      child: const Text('Register', 
                      style: TextStyle(
                        fontSize: 23, 
                        fontWeight: FontWeight.bold
                        ),
                        ), 
                      ),
                  )
                ],
              )
              ),
          ),
        ),
      ),
    );
  }
}