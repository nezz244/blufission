
import 'package:eazimeddz/utils.dart';
import 'package:eazimeddz/utils/global.colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';


import 'main.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;



  SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  _SignUpWidgetState  createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var showsnake = Utils();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(" Employee History"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
        ],
        backgroundColor: GlobalColors.mainColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: SvgPicture.asset(
                      'eazimedslogo.svg',
                      height: 100,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    "Here to Get",
                    style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                  ),
                  Text(
                    "Welcomed !",
                    style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                  ),


                  const SizedBox(height: 4),
                  TextFormField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: 'Email'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        :null,
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min. 6 characters'
                        :null,
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                      decoration: InputDecoration(labelText: "Enter your name"),
                      validator: (value) {
                        if (value!.isEmpty ||
                            RegExp(r'^[0-1]').hasMatch(value!)) {
                          return " Enter correct name";
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(height: 40),
                  TextFormField(
                      decoration:
                      InputDecoration(labelText: "Previous Employer"),
                      validator: (value) {
                        if (value!.isEmpty ||
                            RegExp(r'^[0-1+ $]').hasMatch(value!)) {
                          return " Enter correct name";
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(height: 40),
                  TextFormField(
                      decoration:
                      InputDecoration(labelText: "Emergency Contact"),
                      validator: (value) {
                        if (value!.isEmpty ||
                            RegExp(r'^[a-z A-Z + $]').hasMatch(value!)) {
                          return " Enter correct contact";
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(height: 40),
                  TextFormField(
                      decoration: InputDecoration(labelText: "Home Address"),
                      validator: (value) {
                        if (value!.isEmpty ||
                            RegExp(r'^[$]').hasMatch(value!)) {
                          return " Enter correct home address";
                        } else {
                          return null;
                        }
                      }),
                ],
              ),
            )),
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        alignment: Alignment.center,


        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      color: GlobalColors.mainColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: RichText(
                      text: TextSpan(

                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = signUp,
                            text: 'SignUp',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),

                          )
                        ],

                      ),

                    )
                ),
                Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      color: GlobalColors.mainColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: RichText(
                      text: TextSpan(

                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignIn,
                            text: 'Login',
                            style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),

                          )
                        ],

                      ),

                    )
                ),

              ],
            ),
          ),
        ),
      ),

    );

  }
  Future signUp() async{
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator())
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }on FirebaseAuthException catch (e) {
      print(e);

      Utils().showSnackBar(e.message);
    }
    Navigator.of(context).popUntil((route) => true);
   //navigatorKey.currentState!.popUntil((route) => route);
  }
}

