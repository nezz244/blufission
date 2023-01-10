import 'dart:async';

import 'package:eazimeddz/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'home_page.dart';

class VerifyEmailPage extends StatefulWidget {
   VerifyEmailPage({super.key});

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}


class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;


  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Utils().showSnackBar(e.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
     // changed here

      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
            (_) => checkEmailVerified(),
      );


    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) =>
      isEmailVerified
          ?  HomePage()
          : Scaffold(
        appBar: AppBar(
          title: const Text('Verify Email'),
        ),
        body: Padding(
            padding:  EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(
                  'A Verification email has been sent',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 24,),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(Icons.email, size: 32),
                  label: const Text('Resend Email'),
                  //style: TextStyle(fontSize: 24),
                  onPressed: sendVerificationEmail,
                ),


              ],
            ),



                ),



            );
}







