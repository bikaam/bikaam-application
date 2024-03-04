import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class GetBannerTop1 extends StatefulWidget {
  const GetBannerTop1({Key? key}) : super(key: key);

  @override
  State<GetBannerTop1> createState() => _GetBannerTop1State();
}

class _GetBannerTop1State extends State<GetBannerTop1> {
  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection("admin").doc("banner").collection("Image1banner");
    return Container(
      child: StreamBuilder(
          stream: ref.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text(
                '',
                style: TextStyle(color: Colors.white),
              );
            }
            return Column(
              children: snapshot.data!.docs.map((document)
              {
                return Container(

                  child: Image.network(
                    document['Image1banner'],
                    height: 100,
                    width: 155,
                    fit: BoxFit.cover,
                  ),


                );

              }).toList(),

            );
          }),
    );
  }
}
