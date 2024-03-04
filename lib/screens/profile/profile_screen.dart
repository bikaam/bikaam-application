import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/home/homescreen2.dart';
import 'package:bikaam/screens/home/mainpage.dart';
import 'package:bikaam/screens/show/Following.dart';
import 'package:bikaam/screens/show/favorite.dart';
import 'package:bikaam/screens/show/messages.dart';
import 'package:bikaam/screens/show/notifcation.dart';
import 'package:bikaam/screens/show/ordershow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';

import '../auth1.dart';
import '../show/Video.dart';
import '../usedproduct/homepage/homwpage.dart';

class Profile extends StatefulWidget {


  @override
  State<Profile> createState() => Profile_State();
}

class Profile_State extends State<Profile> {

  set index(int index) {}
  late String userid;
  @override
  Widget build(BuildContext context) {
    int index=0;
    var _selectedIndex = 1;
    int curentIndex=0;

    final items = <Widget>[
      Icon(
        Icons.person,
        size: 30,
      ),
      Icon(
        Icons.home,
        size: 30,
      ),
      Icon(
        Icons.article_outlined,
        size: 30,
      ),
      Icon(
        Icons.storefront,
        size: 30,
      ),

    ];
    var theme;

    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    print(uid);

    CollectionReference ref=FirebaseFirestore.instance.collection(uid);
    return Scaffold(
      body: StreamBuilder(
        stream:ref.snapshots(),
        builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text('no values', style: TextStyle(color: Colors.black),);
          }
          return ListView(
            //padding: EdgeInsets.all(30),
            children: snapshot.data!.docs.map((document) {
              return Column(
                children: [
                  Container(
                      color: Color(0xFFECF2FF),

                    child:Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(Icons.person,color: Colors.cyan[200],size: 50,),
                        ),
                        Column(
                          children: [
                            Text(document["name"],style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold,fontSize: 18),),
                           // Text("Fashion has a new destination !",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 13),)
                          ],
                        )
                      ],
                    )
                  ),
                   SizedBox(height: 20,),
                   Container(
                     child: Text("Fashion has a new destination !",style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold,fontSize: 15),),
                   ),
                   SizedBox(height: 25,),

                   Container(
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.black12)
                     ),
                     child: Row(
                       children: [
                         SizedBox(width: 20,),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20),
                           child: Container(
                             padding:EdgeInsets.all(17   ),
                             decoration: BoxDecoration(
                                 //border: Border.all(color: Colors.black12)
                             ),
                             child: Column(
                               children: [
                                 Text(document['cashback'],style: TextStyle(color: Colors.black),),
                                 Text("المحفظة",style: TextStyle(color: Colors.black),),
                               ],
                             ),

                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20),
                           child: Container(
                             padding:EdgeInsets.all(17   ),
                             decoration: BoxDecoration(
                               //border: Border.all(color: Colors.black12)
                             ),
                             child: Column(
                               children: [
                                 Text(document['messages'],style: TextStyle(color: Colors.black),),
                                 Text("الرسائل",style: TextStyle(color: Colors.black),),
                               ],
                             ),

                           ),
                         ),
                       ],
                     ),
                   ),
                   SizedBox(height: 25,),

                   /////////////////////////////////////////////////////////
                   InkWell(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowNotify()));
                     },
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal:40),
                       child: Container(
                           padding:EdgeInsets.all(17   ),
                           //color: Colors.cyan[100],
                         decoration: BoxDecoration(
                           //color: Colors.teal[100],
                           color: Color(0xFFECF2FF),
                           borderRadius: BorderRadius.circular(25),
                         ),
                         child: Row(
                           children: [
                             Icon(Icons.notifications,color: Colors.cyan[200],size: 30,),
                             SizedBox(width: 10,),
                             Text("الاشعارات",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

                           ],
                         )
                       ),
                     ),
                   ),
                  SizedBox(height: 10,),
/////////////////////////message//////////////////////////////////////////////////////////////////////
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowMessages()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                          padding:EdgeInsets.all(17),
                         // color: Colors.cyan[100],
                          decoration: BoxDecoration(
                            color: Color(0xFFECF2FF),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.message,color: Colors.cyan[200],size: 30,),
                              SizedBox(width: 10,),
                              Text("الرسائل ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

                            ],
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
  ////////////////////offers/////////////////////////////////////////////////////////////////
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderShow()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                          padding:EdgeInsets.all(17),
                          // color: Colors.cyan[100],
                          decoration: BoxDecoration(
                            color: Color(0xFFECF2FF),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.shopping_cart,color: Colors.cyan[200],size: 30,),
                              SizedBox(width: 10,),
                              Text("الطلبات ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

                            ],
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
   /////////////////////////my products///////////////////////////////////////////////////////////////////////////
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Favorite()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                          padding:EdgeInsets.all(17),
                          // color: Colors.cyan[100],
                          decoration: BoxDecoration(
                            color: Color(0xFFECF2FF),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.favorite,color: Colors.cyan[200],size: 30,),
                              SizedBox(width: 10,),
                              Text("المفضلة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

                            ],
                          )
                      ),
                    ),
                  ),
////////////////////////////////////////////////////////////////////////////////////////////////
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Following()));

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                          padding:EdgeInsets.all(17),
                          // color: Colors.cyan[100],
                          decoration: BoxDecoration(
                            color: Color(0xFFECF2FF),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.accessibility_new_rounded,color: Colors.cyan[200],size: 30,),
                              SizedBox(width: 10,),
                              Text("المتاجر  ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

                            ],
                          )
                      ),
                    ),
                  ),
                   //cashback


                ],
              );
            }
            ).toList(),
          );
        }),
      bottomNavigationBar: CurvedNavigationBar(
        //backgroundColor: Colors.blueAccent,
          color: Colors.blue,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.redAccent,
          animationCurve: Curves.easeInOut,
          height: 60,
          index: index,
          animationDuration: Duration(milliseconds: 10),
          items: [
            CurvedNavigationBarItem(
              child: Icon(Icons.perm_identity,color: Colors.white,),
              label: 'ملف شخصي',
              labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.article_outlined,color: Colors.white,),
              label: 'الطلبات',
              labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.home,color: Colors.white,),
              label: 'الرئيسية',
              labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.storefront,color: Colors.white,),
              label: 'المستعمل',
              labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.video_collection,color: Colors.white,),
              label: 'فيدوهات',
              labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
            ),
          ],
          onTap: onItemPressed),


    );
  }

  onItemPressed(
      index,
      ) async {
    switch (index) {
      case 0:
        print('go to person');

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profile()));

        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Auth1()));

        break;

      case 2:
        print('go to home');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));

        break;

        break;

      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));

        break;

      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Video()));
        print('go to settings 3');
        break;
    }
  }


}
