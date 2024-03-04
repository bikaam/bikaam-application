import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class VenderBanner extends StatefulWidget {
  late String value;
  VenderBanner({required this.value});
 // const VenderBanner({Key? key}) : super(key: key);

  @override
  State<VenderBanner> createState() => _VenderBannerState(value);
}

class _VenderBannerState extends State<VenderBanner> {
  String value;
  _VenderBannerState(this.value);
  @override
  Widget build(BuildContext context) {
    CollectionReference ref= FirebaseFirestore.instance.collection(value);
    //int curentIndex=0;
    return
      Container(
       // height:150,
        //width: 300,
        child: StreamBuilder(
            stream:ref.snapshots().where((event) => false),
            builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('no values', style: TextStyle(color: Colors.black),);
              }
              return Container(
               // height:300,
                child: ListView(
                  padding: EdgeInsets.all(30),
                  children: snapshot.data!.docs.map((document) {
                    return  Container(
                      decoration: BoxDecoration(
                        //color: Colors.teal[100],
                        //color: Color(0xFFECF2FF),
                        borderRadius: BorderRadius.circular(100),
                      ),

                      child: Image.network( document['imageUrl'],width: 200,fit: BoxFit.fill,),
                    );
                  }
                  ).toList(),
                ),
              );
            }


    ),
      );
  }
}
