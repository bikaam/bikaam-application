import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
class ShowNotify extends StatefulWidget {
  const ShowNotify({Key? key}) : super(key: key);

  @override
  State<ShowNotify> createState() => _ShowNotifyState();
}

class _ShowNotifyState extends State<ShowNotify> {
  @override
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection(uid).doc("orders").collection("notify");

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.grey,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Text("الاشعارات", style: Theme.of(context).textTheme.bodyText1,)
            ),
            //const SizedBox(width: defaultPadding / 2),

            const SizedBox(width: defaultPadding* 4),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(
                "assets/images/logo.png",
                width: 90,
              ),
            ),
          ],
        ),


      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Container(
                  child: Text(
                    'لا يوجد بيانات', style: TextStyle(color: Colors.black,fontSize: 20),),
                ),
              );
            }
            return Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child:  ListView(

                  children: snapshot.data!.docs.map((document) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(

                        color: Colors.grey[100],


                       child: Row(
                          children: [
                            CircleAvatar(
                              radius:25,
                              backgroundColor: Colors.grey[100],
                              backgroundImage:NetworkImage(
                                document['image'],

                              ) ,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                //transformAlignment: Alignment.topRight,
                                //padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [

                                    Container(

                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(document["sendername"],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                      ),
                                      //color: Colors.grey,
                                    ),

                                    Text(document['notify']),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                      ),
                    );
                  }).toList(),
                ),),


            );
          }),

    );
  }
}
