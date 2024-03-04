import 'package:bikaam/screens/show/showCatItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../NEW/newfile.dart';
import '../../models/scroll.dart';

class ListCategory extends StatefulWidget {
  late String value;
  ListCategory({required this.value});
  //const ListCategory({Key? key}) : super(key: key);

  @override
  State<ListCategory> createState() => _ListCategoryState(value);
}

class _ListCategoryState extends State<ListCategory> {
  String value;
  _ListCategoryState(this.value);
  @override
  scroll() {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            //color: Colors.grey,

            padding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Color(0xFFECF2FF),
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Container(),
            ),
          );
        });
  }


  Widget build(BuildContext context) {
   // FirebaseAuth auth= FirebaseAuth.instance;
   // String uid=auth.currentUser!.uid.toString();

    CollectionReference ref= FirebaseFirestore.instance.collection(value).doc("categories").collection("Categories");
    return Container(
        height:30,

        //width: 300,
        child:
        StreamBuilder(
            stream:ref.snapshots(),
            builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('no values', style: TextStyle(color: Colors.black),);
              }
              return GestureDetector(
               // onTap: goToCat,
                child: Container(
                  width: 285,
                  // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    children: snapshot.data!.docs.map((document) {
                      return
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage2(value:value,cat: document['category'], )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              //   width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(document['category'],style: TextStyle(color: Colors.black),),
                              )),
                            ),
                          ),
                        );
                    }
                    ).toList(),
                  ),
                ),
              );
            }


        ),
      );
  }
}
