import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netflix/screens/firstscreen.dart';
import 'package:netflix/screens/home_screen.dart';
import 'package:netflix/screens/loginscreen.dart';
import 'package:netflix/screens/signupscreen.dart';
import 'screens/movie_details.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initializing the firebase app
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Widget checkuser(){
    if(auth.currentUser != null){
      return homescreen();
    }
    return FirstScreen();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      home: checkuser(),
    );
  }
}
