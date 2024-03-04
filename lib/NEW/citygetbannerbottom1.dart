import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CityGetBannerBottom1 extends StatefulWidget {
  late String value;

  CityGetBannerBottom1({required this.value});
  //const CityGetBannerBottom1({Key? key}) : super(key: key);

  @override
  State<CityGetBannerBottom1> createState() => _CityGetBannerBottom1State(value);
}

class _CityGetBannerBottom1State extends State<CityGetBannerBottom1> {
  String value;
  _CityGetBannerBottom1State(this.value);
  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection(value).doc("banner").collection("Image1banner2");
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
                return Column(
                  children: [
                    Container(
                      child: Image.network(
                        document['Image1banner2'],
                        height: 100,
                        width: 155,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              }).toList(),

            );
          }),
    );
  }
}
