import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/profile/profile_screen.dart';
import 'package:bikaam/screens/show/Log.dart';
import 'package:bikaam/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../show/Cart.dart';
class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream : FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Cart();
          }
          else
          {
            return Log();
          }
        },
      ),

    );
  }
}
