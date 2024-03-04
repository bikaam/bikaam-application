import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CityGetBannerTop1 extends StatefulWidget {
  late String value;

  CityGetBannerTop1({required this.value});
  //const CityGetBannerTop1({Key? key}) : super(key: key);

  @override
  State<CityGetBannerTop1> createState() => _CityGetBannerTop1State(value);
}

class _CityGetBannerTop1State extends State<CityGetBannerTop1> {
  String value;
  _CityGetBannerTop1State(this.value);
  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection(value).doc("banner").collection("Image1banner");
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
