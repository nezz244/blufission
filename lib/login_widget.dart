
import 'package:eazimeddz/utils.dart';
import 'package:eazimeddz/utils/global.colors.dart';
import 'package:eazimeddz/widgets/social.login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';

import 'forgot_password_page.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);
  @override


  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
   Scaffold(
  body: Container(
  child: SizedBox(
  child: SingleChildScrollView(
  child: SafeArea(
  child: Container(
  color: Colors.white,
  width: double.infinity,
  padding: const EdgeInsets.all(15.0),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  //moved stuff down

  const SizedBox(
  height: 50,
  ),
  Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
  children: [
  Container(
  alignment: Alignment.topLeft,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(6),
  ),
  child: IconButton(
  icon: const Icon(
  Icons.account_circle,
  color: Colors.black,
  ),
  onPressed: () {
  // do something
  },
  ),
  ),
  Container(
  alignment: Alignment.topRight,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(6),
  ),
  child: Row(
  children: [
  IconButton(
  icon: const Icon(
  Icons.arrow_drop_down,
  color: Colors.black,
  ),
  onPressed: () {
  // do something
  },
  ),
  Text(
  'Patient',
  style: TextStyle(
  color: GlobalColors.textColor,
  fontSize: 16,
  fontWeight: FontWeight.w500,
  ),
  ),
  ],
  ),
  ),
  ],
  ),
  ),
  const SizedBox(
  height: 50,
  ),
  Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
  alignment: Alignment.center,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(6),
  ),
  child: SvgPicture.asset(
  'images/doctor.svg',
  height: 170,
  ),
  ),
  ),
  const SizedBox(
  height: 100,
  width: 100,
  ),
  Text(
  'Hello User Please Login to your account',
  style: TextStyle(
  color: GlobalColors.textColor,
  fontSize: 16,
  fontWeight: FontWeight.w500,
  ),
  ),
      SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              TextField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: passwordController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
          InkWell(
            onTap: signIn ,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 300,
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
                child: Container(
                  child: const Text(
                    'Sign In ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
              SizedBox(height: 24),
              GestureDetector(
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: GlobalColors.mainColor,
                    fontSize: 20,
                  ),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ForgotPasswordPage(),
                )
                ),
              ),



            ],



          )

      ),
    const SizedBox(),
    const SocialLogin(),
  ]
  )
  )
  )
  )
  )

  ),
     bottomNavigationBar: Container(
     height: 25,
     decoration: BoxDecoration(
       color: GlobalColors.mainColor,
       borderRadius: BorderRadius.circular(2),
       boxShadow: [
         BoxShadow(
           color: Colors.black.withOpacity(0.1),
           blurRadius: 10,
         ),
       ],
     ),
     alignment: Alignment.center,
     child: RichText(
     text: TextSpan(
     style: TextStyle(color: Colors.white,fontSize: 20),
       text: 'No Account?',
       children: [
         TextSpan(
           recognizer: TapGestureRecognizer()
             ..onTap = widget.onClickedSignUp,
           text: 'Sign Up',
           style: TextStyle(
               decoration: TextDecoration.underline,
               color: Theme.of(context).colorScheme.secondary

           ),

         )
       ]

   ),

  ),
   ),
          );


  Future signIn() async {

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }on FirebaseAuthException catch (e) {
      print(e);
      Utils().showSnackBar(e.message);
    }
    //fix navigator key 
    var navigatorKey;
    navigatorKey.currentState
        ?.popUntil((route) => route.isFirst);
    // navigatorKey.currentState.popUntil((route)=> route)
  }

}
