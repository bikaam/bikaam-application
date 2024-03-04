
import 'package:bikaam/screens/show/showCatItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../NEW/newfile.dart';
import '../home/venderpage.dart';
class SelectedCat extends StatefulWidget {
  late String value;
  late String VendorId;

  SelectedCat({required this.value,required this.VendorId});
  //const SelectedCat({Key? key}) : super(key: key);

  @override
  State<SelectedCat> createState() => _SelectedCatState(value,VendorId);
}

class _SelectedCatState extends State<SelectedCat> {
  String value;
  String VendorId;
  _SelectedCatState(this.value,this.VendorId);
  @override
  Widget build(BuildContext context) {

    //FirebaseAuth auth= FirebaseAuth.instance;
    //String uid=auth.currentUser!.uid.toString();

    CollectionReference ref= FirebaseFirestore.instance.collection(VendorId).doc("categories").collection("Categories");
    return
      Container(
        height:50,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black12),
          color: Colors.white,
        ),
        //width: 300,
        child: StreamBuilder(
            stream:ref.snapshots(),
            builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('', style: TextStyle(color: Colors.black),);
              }
              return GestureDetector(
                //onTap: goToCat,
                child: Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage1(value:VendorId)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 50,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Center(child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text("الكل",style: TextStyle(color: Colors.black),),
                            )),
                          ),
                        ),
                      ),
                      Container(
                        width: 270,

                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(10),
                          children: snapshot.data!.docs.map((document) {
                            return  InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage2(value:VendorId,cat: document['category'], )));

                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowCatItem(value:document['category'],VendorId: VendorId, )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  //width: 50,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: document['category']==value ? Colors.blue: Colors.white ,
                                    //color: Colors.white,
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  child: Center(child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(document['category'],style: TextStyle(color: document['category']==value ? Colors.white: Colors.black ,),),
                                  )),
                                ),
                              ),
                            );



                          }
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }


        ),
      );
  }
}
