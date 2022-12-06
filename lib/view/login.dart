import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/controller/auths.dart';
import 'package:providerapp/provider/userdetail.dart';
import 'package:providerapp/view/forgotpassword.dart';
import 'package:providerapp/view/homescreen.dart';
import 'package:providerapp/view/real_login_screen.dart';
import 'package:providerapp/view/registrationform.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  final _formKey = GlobalKey<FormState>();

  // Variable declaration for remember me
  bool isRememberMe = false;

  // Variable declaration for password visible or invisible
  late bool _passwordVisible;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  // Obejct of auth class
  AuthServices au = AuthServices();

  // remember me function
  void rememberMe(bool value) {
    isRememberMe = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("rememberMe", value);
      prefs.setString("email", au.logEmails.text);
      prefs.setString("password", au.logPass.text);
    });

    setState(() {
      isRememberMe = value;
      print(isRememberMe);
      print(au.logEmails.text);
      print(au.logPass.text);
    });
    
  }

  // loads email and password
void _loadUserEmailPassword() async {
try {
SharedPreferences _prefs = await SharedPreferences.getInstance();
var _email = _prefs.getString("email") ?? "";
var _password = _prefs.getString("password") ?? "";
var _remeberMe = _prefs.getBool("remember_me") ?? false;
print(_remeberMe);
print(_email);
print(_password);
print("my loves");
if (_remeberMe) {
setState(() {
isRememberMe = true;
});
au.logEmails.text = _email ?? "";
au.logPass.text = _password ?? "";
}
} catch (e) 
{
print(e);
}
}


  @override
  void initState() {
    _passwordVisible = false;
    _loadUserEmailPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
                vertical: 120
            ),
            child: Form(
             key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                ),
               const  SizedBox(height: 43,),

                  // Email Address
                  Container(
                    alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2)
              )
            ]
          ),
          height: 60,
                    child: TextFormField(
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
                  ),
        
                const SizedBox(height: 25,),
        
                // Password
                Container(
                  alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2)
              )
            ]
          ),
          height: 60,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: !_passwordVisible,
                    controller: au.logPass,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            // Update the state
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        ),
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
                ),

                SizedBox(height: 10,),

                // Forget Password text

                Container(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyLoginPage()));
        }, 
      child: const Padding(
        padding: EdgeInsets.only(right: 0),
        child: Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            ),
        ),), 
      ),
      
      ),

                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyLoginPage()));
                //   },
                //   child: const Padding(
                //     padding: EdgeInsets.only(top: 12.0, left: 190),
                //     child: Text("Forgot Password", style: TextStyle(color: Colors.blueAccent),),
                //   ),
                // ),

                // const SizedBox(height: 20,),

                 Container(
      height: 20,
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white), 
            child: Checkbox(
            value: isRememberMe, 
            checkColor: Colors.blueAccent,
            activeColor: Colors.white,
            onChanged: (value) {
              rememberMe(value!);
            }
              ),
            ),
          const Text(
            'Remember Me',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    ),

    const SizedBox(height: 30,),

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
    //                 final postModel = Provider.of<UserDetail>(context, listen: false);
    // postModel.getTotalScore();
                        
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
             const SizedBox(height: 15,),
              const Text("OR",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
              ),
             const SizedBox(height: 15,),

              // Google SignIn
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 60),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
                ),
               onPressed: () {
                print("Hello World");
               }, 
                icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red,), 
                label: const Text('Sign Up with Google',
                style: TextStyle(
                    fontSize: 23, 
                    fontWeight: FontWeight.bold
                    ),),
                ),

              // Text for registration
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 75.0),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text("Need an account?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    ),
                    ),
                    GestureDetector(
                      onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegistrationForm()));
                     },
                      child: const Text(" SIGN UP", 
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold, 
                        color: Colors.white),
                        )
                        ),
                  ],
                ),
              )
                ],
              ),
            ),
          ),
        )
      )
      );
    
  }
}
