import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';



class GetBannerTimer extends StatefulWidget {
  const GetBannerTimer({Key? key}) : super(key: key);

  @override
  State<GetBannerTimer> createState() => _GetBannerTimerState();
}

class _GetBannerTimerState extends State<GetBannerTimer> {

  @override
  Widget build(BuildContext context) {
    CollectionReference ref =FirebaseFirestore.instance.collection("admin").doc("products").collection("Timer");

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
                    SlideCountdown(

                      duration:Duration(days:int.parse(document["time"])),
                      //padding: defaultPadding,
                      slideDirection: SlideDirection.up,
                      //countUp: true,
                      separatorType: SeparatorType.title,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    SizedBox(height: 7,),
                    Container(
                      child: Image.network(
                        document[''],
                        height: 100,
                        width: 300,
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
