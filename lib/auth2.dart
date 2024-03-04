
import 'package:bikaam/SignScreen.dart';
import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/home/homescreen2.dart';
import 'package:bikaam/screens/loginscreen.dart';
import 'package:bikaam/screens/profile/profile_screen.dart';
import 'package:bikaam/screens/show/Log.dart';
import 'package:bikaam/screens/signup.dart';
import 'package:bikaam/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Auth2 extends StatefulWidget {

  @override
  State<Auth2> createState() => _Auth2State();
}

class _Auth2State extends State<Auth2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream : FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
           return Profile();
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