
import 'package:bikaam/SignScreen.dart';
import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/home/homescreen2.dart';
import 'package:bikaam/screens/loginscreen.dart';
import 'package:bikaam/screens/profile/profile_screen.dart';
import 'package:bikaam/screens/show/Log.dart';
import 'package:bikaam/screens/show/ordershow.dart';
import 'package:bikaam/screens/signup.dart';
import 'package:bikaam/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Auth1 extends StatefulWidget {

  @override
  State<Auth1> createState() => _Auth1State();
}

class _Auth1State extends State<Auth1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream : FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return OrderShow();
          }
          else
          {
            print('not login');
            return SignUpPage();
          }
        },
      ),

    );
  }
}