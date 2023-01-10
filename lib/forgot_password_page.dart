
import 'package:eazimeddz/utils.dart';
import 'package:flutter/foundation.dart';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class ForgotPasswordPage extends StatefulWidget{
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();

}
class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();


  @override
  void dispose(){
    emailController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Reset Password'),
      ),
      body:
      Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Receive an email to\n reset your password',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),

                  ),
                  const SizedBox(height : 20 ),
                  TextFormField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText:'Email' ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        :null,

                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),

                    ),
                    icon: const Icon(Icons.email_outlined),
                    label: const Text(
                      'Reset Password',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: verifyEmail,),
                ],
              )
          ))
  );
  Future verifyEmail() async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context)=> const Center(child: CircularProgressIndicator()),

    );
    try{
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Utils().showSnackBar('Password Reset Email Sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e){
      if (kDebugMode) {
        print(e);
      }

      Utils().showSnackBar(e.message);
      Navigator.of(context).pop();

    }
  }
}