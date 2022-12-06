import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:providerapp/controller/auths.dart';
import 'package:providerapp/view/forgotpassword.dart';
import 'package:providerapp/view/homescreen.dart';
import 'package:providerapp/view/real_login_screen.dart';
import 'package:providerapp/view/registrationform.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  // Obejct of auth class
  AuthServices au = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/loginimage2.png'),
            alignment: Alignment.topCenter,
            fit: BoxFit.cover

            )         
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 305, left: 20, right: 20),
            child: Center(
              child: Form(
               key: _formKey,
                child: Column(
                  children: [
        
                    // Email Address
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: au.logEmails,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      hintText: "Enter Your Email",
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
        
                  const SizedBox(height: 25,),
        
                  // Password
                  TextFormField(
                    obscureText: true,
                    controller: au.logPass,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Enter Your Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blueAccent, width: 32.0)
                      ),
                      
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return "Required this field";
                      }
                      return null;
                    },
                    
                  ),

                  // Forget Password text
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyLoginPage()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 12.0, left: 190),
                      child: Text("Forgot Password", style: TextStyle(color: Colors.blueAccent),),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  // Login Button
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
                        bool isValid = EmailValidator.validate(au.logEmails.text);
                        if (isValid) {
                        au.loginUser(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          
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
                    child: const Text('Login', 
                    style: TextStyle(
                      fontSize: 23, 
                      fontWeight: FontWeight.bold
                      ),
                      ), 
                    ),
                    
                ),

                // Text -OR- keyword

                const Text("--- OR ---",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                ),

                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 75.0),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text("Need an account?"),
                      GestureDetector(
                        onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegistrationForm()));
                       },
                        child: const Text(" SIGN UP", 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          color: Colors.blueAccent),
                          )
                          ),
                    ],
                  ),
                )
                  ],
                ),
              )
              ),
          ),
        )
      )
          
          
    
      );
    
  }
}
