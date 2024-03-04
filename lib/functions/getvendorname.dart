import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetVendorName extends StatefulWidget {
  late String value;
  GetVendorName({required this.value});

  @override
  State<GetVendorName> createState() => _GetVendorNameState(value);
}

class _GetVendorNameState extends State<GetVendorName> {
  String value;

  _GetVendorNameState(this.value);
  @override
  Widget build(BuildContext context) {
    TextEditingController _text=TextEditingController();
    CollectionReference ref = FirebaseFirestore.instance.collection(value);
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
                return Container(
                  child: Text("From :"+document["name"],style: TextStyle(fontSize: 13,color: Colors.grey,fontWeight: FontWeight.bold),),

                );
              }).toList(),

            );
          }),
    );
  }
}
