import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix/buttondata.dart';
import 'package:netflix/screens/loginscreen.dart';
import 'package:netflix/screens/signupscreen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: Lottie.network(
                'https://assets2.lottiefiles.com/packages/lf20_khzniaya.json'),
          ),
          Spacer(),
          NewButton(buttonText: 'Signup', onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
          }),
          SizedBox(height: 10,),
          NewButton(buttonText: 'Login', onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          }),

        ],
      ),
    );
  }
}
