import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import 'package:bikaam/screens/home/venderpage.dart';
class Following extends StatefulWidget {
  const Following({Key? key}) : super(key: key);

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers");

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.grey,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Text("المتاجر المفضلة", style: Theme.of(context).textTheme.bodyText1,)
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
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Container(
                  child: Text(
                    'لا يوجد بيانات',
                    style: TextStyle(color: Colors.black,fontSize:20 ),
                  ),
                ),
              );
            }

            return Scaffold(
              backgroundColor: Colors.grey[100],
              body: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    mainAxisExtent: 250,
                  ),
                  children: snapshot.data!.docs.map((document) {
                    return InkWell(
                      onTap: (){
                        //getUsersData(document['uid']);


                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage1(value: document['venderid'])));
                        },
                      child: SizedBox(
                        height: 600,
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                //fit: StackFit.expand,
                                children: [
                                  Container(
                                    // margin: const EdgeInsets.only(bottom: 50),
                                    height: 120,
                                    //color: Color(0xFFECF2FF),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(60),
                                          bottomLeft: Radius.circular(30)),
                                      color: Colors.black,
                                    ),
                                    child: Image.network(
                                      document['coverUrl'],
                                      //height: 150,
                                      //  width:350,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                    top: 75,
                                    left: 45,
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey[100],
                                      backgroundImage:NetworkImage(
                                        document['imageUrl'],

                                      ) ,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 37,),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  document['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 7,
                                ),
                                // color: Colors.cyan,
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/icons/Location.svg"),
                                    const SizedBox(width: defaultPadding / 2),
                                    Text(document['address'],
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 5,
                                ),
                                // color: Colors.cyan,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 0.0),
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.grey[400],
                                        size: 15,
                                      ),
                                    ),
                                    const SizedBox(width: defaultPadding / 2),
                                    Text(document['phone'],
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                              ),



                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }),
    );
  }
}
