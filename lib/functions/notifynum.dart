import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class NotifyNum extends StatefulWidget {
  const NotifyNum({Key? key}) : super(key: key);

  @override
  State<NotifyNum> createState() => _NotifyNumState();
}

class _NotifyNumState extends State<NotifyNum> {
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
                    Positioned(
                      top: 15,
                      // left:7,
                      right: 20,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(document["notifynum"],style: TextStyle(fontSize: 8),),
                      ),
                    )
                  ],
                );
              }).toList(),

            );
          }),
    );
  }
}
