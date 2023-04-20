import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:netflix/models/signupdatamodel.dart';
import 'package:netflix/screens/home_screen.dart';
import 'package:netflix/screens/signupscreen.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../buttondata.dart';
import '../models/auth_exceptional_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = true;
  AuthExceptionHandler exceptionHandler = AuthExceptionHandler();
  final FirebaseAuth auth = FirebaseAuth.instance;
  SignupDataModel dataModel = SignupDataModel();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email = "";
  String email2 = "";
  String password = "";

  bool showspinner = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: SafeArea(
            child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Center(
                        child: Text(
                      'Hello Again!',
                      style: TextStyle(fontSize: 25),
                    ))),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                    width: 260,
                    child: Text(
                      "Welcome back you've been missed ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(
                  height: 50,
                ),
                NewInputField(
                  obscuretext: false,
                  text: 'Enter mail',
                  validator: (value) {
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    print(emailValid);
                    if (value == null || value.isEmpty) {
                      return "email should not be empty";
                    }
                    if (!emailValid) {
                      return "email not valid";
                    }
                    return null;
                  },
                  icon: Icon(Icons.email),
                  onPressed: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                NewInputField(
                  suffixicon: IconButton(icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),onPressed: (){
                           setState(() {
                             passwordVisible = !passwordVisible;
                           });
                  },),
                  obscuretext: passwordVisible,
                  text: 'password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Value should not be empty";
                    }
                    return null;
                  },
                  icon: Icon(Icons.password),
                  onPressed: (value) {
                    password = value;
                  },
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const Text('Recovery Password'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Recover Password"),
                            actions: <Widget>[
                              NewInputField(
                                obscuretext: false,
                                text: 'Enter email',
                                validator: (value) {
                                final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!);
                                print(emailValid);
                                if (value == null || value.isEmpty) {
                                  return "email should not be empty";
                                }
                                if (!emailValid) {
                                  return "email not valid";
                                }
                                return null;
                              },
                                icon: Icon(Icons.email), onPressed: (value){
                                email2 = value;
                              },
                              ),
                              SizedBox(height: 10,),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: NewButton(buttonText: 'Send', onPressed: () async {
                               AuthStatus status =  await exceptionHandler.resetPassword(email: email2);
                           if(status == AuthStatus.successful){
                                 Navigator.pop(context);
                                 const snackdemo = SnackBar(
                                   content: Text('Email sent successfully'),
                                   backgroundColor: Colors.green,
                                   elevation: 10,
                                   behavior: SnackBarBehavior.floating,
                                   margin: EdgeInsets.all(5),
                                 );
                                 ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                               }

                                })
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                NewButton(
                  buttonText: 'Sign in',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final navigator = Navigator.of(context);
                      setState(() {
                        showspinner = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        navigator.pushReplacement(MaterialPageRoute(
                            builder: (context) => const homescreen()));
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        showspinner = false;
                      });
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
                    onPressed: () async {
                      UserCredential value =
                          await dataModel.signInWithFacebook();
                      if (value != null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => homescreen()));
                      } else {
                        print(value);
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                        },
                        child: Text('Register'))
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
