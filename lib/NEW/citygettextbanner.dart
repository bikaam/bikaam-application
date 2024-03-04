import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CityGetTextBanner extends StatefulWidget {
  //const GetTextBanner({Key? key}) : super(key: key);
  late String value;

  CityGetTextBanner({required this.value});

  @override
  State<CityGetTextBanner> createState() => _CityGetTextBannerState(value);
}

class _CityGetTextBannerState extends State<CityGetTextBanner> {
  String value;
  _CityGetTextBannerState(this.value);
  @override
  Widget build(BuildContext context) {
    const _colorizeTextStyle = TextStyle(
        fontSize: 15.0,
        fontFamily: 'Horizon',
        fontWeight: FontWeight.bold,
        color: Colors.white
    );
    CollectionReference ref = FirebaseFirestore.instance.collection(value).doc("banner").collection("textbanner");

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
                     // color: Colors.red[900],
                      decoration: BoxDecoration(
                          color: Colors.red[900],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black12,)

                      ),
                      height: 50,
                      width:330,
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                            color: Colors.red[900],

                            child:AnimatedTextKit(
                              animatedTexts: [
                                RotateAnimatedText(document["textbanner"],textStyle:_colorizeTextStyle ),
                              ],
                              isRepeatingAnimation: true,
                              totalRepeatCount: 100,
                            )
                        ),
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
