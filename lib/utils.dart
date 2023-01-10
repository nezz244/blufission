import 'package:flutter/material.dart';

class Utils{
  var messengerKey = GlobalKey<ScaffoldMessengerState>();
   showSnackBar(String? text){
    if (text ==null) return;
else{
    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}}