
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/controller/auths.dart';
import 'package:providerapp/provider/userdetail.dart';
import 'package:providerapp/provider/dataprovider.dart';
import 'package:providerapp/view/login.dart';


void main() async {

  // Initialize the firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => DataProvider()),
      ChangeNotifierProvider(create: (_) => UserDetail()),
      ChangeNotifierProvider(create: (_) => AuthServices()),
    ],
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  AuthServices au = AuthServices();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
      return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: login(),
        );
  }
}



