import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class GetVenderFollowNum extends StatefulWidget {
  const GetVenderFollowNum({Key? key}) : super(key: key);

  @override
  State<GetVenderFollowNum> createState() => _GetVenderFollowNumState();
}

class _GetVenderFollowNumState extends State<GetVenderFollowNum> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    TextEditingController _text=TextEditingController();
    CollectionReference ref = FirebaseFirestore.instance.collection(uid);
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
                    Container(
                        color: Colors.white,
                        child:Text(document['followers'],style: TextStyle(fontSize: 12),)
                    ),
                  ],
                );
              }).toList(),

            );
          }),
    );
  }
}
