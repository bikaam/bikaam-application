
import 'package:bikaam/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FollowButton extends StatefulWidget {
  late String value;

  FollowButton({required this.value});
 // const FollowButton({Key? key}) : super(key: key);

  @override
  State<FollowButton> createState() => _FollowButtonState(value);
}

class _FollowButtonState extends State<FollowButton> {
  String value;
  _FollowButtonState(this.value);



  @override
  go()async{
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    final isfollow = FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(value);
    final user = FirebaseFirestore.instance.collection("user").doc(value);
    if( ((await isfollow.get())!.exists)){
      return FlatButton(
        onPressed: () {
          // print(document["uid"]);
        /*  Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage1(
                      value: document['uid']))); */
        },
        child: Text(
          "following",
          style: TextStyle(color: Colors.black),
        ),
        color: Color(0xFFECF2FF),
      );
    }
    else {
      return FlatButton(
        onPressed: () {
          // print(document["uid"]);
          /*  Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage1(
                      value: document['uid']))); */
        },
        child: Text(
          "Follow",
          style: TextStyle(color: Colors.black),
        ),
        color: Colors.blue,
      );
    }
  }
  Widget build(BuildContext context) {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    TextEditingController _text=TextEditingController();
    CollectionReference ref = FirebaseFirestore.instance.collection(value);
    final coll= FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(value).get();
    print(coll);

    return Container(
      child: StreamBuilder(
          stream: ref.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text(
                '0',
                style: TextStyle(color: Colors.black),
              );
            }

            return Column(
              children: snapshot.data!.docs.map((document)
              {
                return Column(
                  children: [

                  ],
                );
              }).toList(),

            );
          }),
    );
  }
}
