
import 'package:bikaam/screens/show/selectedproductsCat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'categoryselect.dart';


class ShowCatItem extends StatefulWidget {
  late String value;
  late String VendorId;

  ShowCatItem({required this.value,required this.VendorId});

  @override
  State<ShowCatItem> createState() => _ShowCatItemState(value,VendorId);
}

class _ShowCatItemState extends State<ShowCatItem> {
  String value;
  String VendorId;
  _ShowCatItemState(this.value,this.VendorId);
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //FirebaseAuth auth= FirebaseAuth.instance;
   // String uid=auth.currentUser!.uid.toString();

    CollectionReference ref= FirebaseFirestore.instance.collection(VendorId).doc("categories").collection("products");
    return Scaffold(


      body: StreamBuilder(
          stream:ref.snapshots(),
          builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot) {

            if (!snapshot.hasData) {
              print("no value");
              return Text('no values', style: TextStyle(color: Colors.black),);

            }
            return Scaffold(
              backgroundColor: Colors.grey[100],
              body:
              ListView(
                children: [
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 20,),


                        SizedBox(height: 20,),
                        SelectedCat(value: value, VendorId: VendorId,),
                        // SizedBox(height: 20,),
                        SizedBox(height: 10,),
                        ShowCatProducts(value:value,venderId: VendorId,),
                        //SizedBox(height: 20,),

                        //ShowProducts(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),


    );
  }
}
