import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CartNum extends StatefulWidget {
  const CartNum({Key? key}) : super(key: key);

  @override
  State<CartNum> createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    TextEditingController _text=TextEditingController();
    CollectionReference ref = FirebaseFirestore.instance.collection(uid);
    return Positioned(
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
                return Container(
                  child:
                    Positioned(
                      top: 15,
                      // left:7,
                      right: 20,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(document["cartnum"],style: TextStyle(fontSize: 8),),
                      ),
                    )

                );
              }).toList(),

            );
          }),
    );
  }
}
