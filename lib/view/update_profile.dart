import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/controller/auths.dart';
import 'package:providerapp/provider/userdetail.dart';
import 'package:providerapp/view/viewprofile.dart';

class UpdateMyProfile extends StatefulWidget {
  const UpdateMyProfile({super.key});

  @override
  State<UpdateMyProfile> createState() => _UpdateMyProfileState();
}

class _UpdateMyProfileState extends State<UpdateMyProfile> {

  final _formKey = GlobalKey<FormState>();

  // Variable declaration for password visible or invisible
  late bool _passwordVisible;

  // final userNameController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  // final TextEditingController mobileController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passController = TextEditingController();

  UserDetail ud = UserDetail();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final postModel = Provider.of<UserDetail>(context, listen: false);
    postModel.getUserDetail();
    ud.userNameController.text = postModel.getName;
    ud.addressController.text = postModel.getAddress;
    ud.mobileController.text = postModel.getPhone;
    ud.emailController.text = postModel.getEmail;
    ud.passController.text = postModel.getPassword;

     _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {

    final postModel = Provider.of<UserDetail>(context, listen: false);
   // postModel.getUserDetail();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyProfile()))
        ),
        centerTitle: true,
        title: const Text("Update Profile"),
      ),
      
      body: Container(
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
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 20.0, right: 20, bottom: 20),
            child: Column(
              children: [
        
                // Username 
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    child: TextFormField(
                      controller: ud.userNameController,
                      
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        label: Text("Name"),
                        hintText: "Enter User name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(),
                        )
                      ),
                      
                      
                    ),
                  ),
                ),
        
        
                // Address 
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: ud.addressController,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        label: Text("Address"),
                        hintText: "Enter Your Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide()
                        )
                      ),
                      
                      
                    ),
                  ),
                ),
        
                // Mobile Number
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    child: TextFormField(
                      controller: ud.mobileController,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        label: Text("Mobile"),
                        hintText: "Enter Mobile Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide()
                        )
                      ),
                     
                    ),
                  ),
                ),
        
                // Email
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    child: TextFormField(
                      controller: ud.emailController,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                      readOnly: true,
                      decoration: InputDecoration(
                        label: Text("Email"),
                        hintText: "Enter Your Email Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide()
                        )
                      ),
                      
                    ),
                  ),
                ),

                // Password Form 
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    child: TextFormField(
                       obscureText: !_passwordVisible,
                      controller: ud.passController,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
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
                        label: Text("Password"),
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide()
                        )
                      ),
                      
                    ),
                  ),
                ),
        
                const SizedBox(height: 15.0,),

                // Elevated Button
                Container(
                  child: SizedBox(
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
                        ud.updateUser();
                        dispose();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
                      }, 
                      child: const Text('Update', 
                      style: TextStyle(
                        fontSize: 23, 
                        fontWeight: FontWeight.bold
                        ),
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