

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:netflix/models/signupdatamodel.dart';
import 'package:netflix/screens/home_screen.dart';
import 'package:netflix/screens/loginscreen.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../buttondata.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  SignupDataModel dataModel = SignupDataModel();
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool showspinner = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 50),
                      )),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                NewInputField(
                  onPressed: (value) {
                    email = value;
                  },
                  text: 'Enter mail',
                  icon: Icon(Icons.email),
                  validator: (value){
                    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                    print(emailValid);
                    if(value == null || value.isEmpty){
                      return "email should not be empty";
                    }
                    if(!emailValid){
                      return "email not valid";
                    }
                return null;
                  },

                ),
                SizedBox(
                  height: 20,
                ),
                NewInputField(
                  onPressed: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Value should not be empty";
                    }
                    return null;
                  },
                  text: 'password',
                  icon: Icon(Icons.password),
                ),
                SizedBox(
                  height: 20,
                ),
                NewButton(
                  buttonText: 'Sign in',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final navigator = Navigator.of(context);
                      setState(() {
                        showspinner = true;
                      });
                      try {
                        final user = await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);

                        navigator.pushReplacement(MaterialPageRoute(
                            builder: (context) => homescreen()));
                      } catch (e) {
                        print(e);
                      } finally {
                        setState(() {
                          showspinner = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: SocialLoginButton(
                    borderRadius: 100,
                    buttonType: SocialLoginButtonType.google,
                    onPressed: () {
                      dataModel.signup(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: SocialLoginButton(
                    borderRadius: 100,
                    buttonType: SocialLoginButtonType.facebook,
                    onPressed: () {},
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already a member?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text('Login'))
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

}
