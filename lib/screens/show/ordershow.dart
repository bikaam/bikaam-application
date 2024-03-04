import 'package:bikaam/functions/getvendorname.dart';
import 'package:bikaam/screens/home/mainpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth2.dart';
import '../../constants.dart';
import '../home/home_screen.dart';
import '../home/homescreen2.dart';
import '../profile/profile_screen.dart';
import '../usedproduct/homepage/homwpage.dart';
import 'Cart.dart';
import 'Video.dart';
class OrderShow extends StatefulWidget {
  const OrderShow({Key? key}) : super(key: key);

  @override
  State<OrderShow> createState() => _OrderShowState();
}

class _OrderShowState extends State<OrderShow> {
  set index(int index) {}
  late String userid;
  @override
  Widget build(BuildContext context) {
    int index = 1;
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
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection(uid).doc("orders").collection("orders");
    userid=uid;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        //backgroundColor: Colors.grey,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [


            const SizedBox(width: defaultPadding / 2),
            Text(
              "My Orders",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(width: defaultPadding * 2),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(
                "assets/images/logo.png",
                width: 90,
              ),
            ),
          ],
        ),

        actions: [

          IconButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => Cart()));

            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.grey[400],
              size: 30,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text(
                'لا يوجد بيانات', style: TextStyle(color: Colors.orange),);
            }

            return Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                //color: Colors.grey[200],
                child: Column(
                    children: [
                      SizedBox(height: 10,),

                      Expanded(
                        child: ListView(

                          children: snapshot.data!.docs.map((document) {
                            return Padding(
                             padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 7),
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  //color: Colors.teal,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: Row(
                                  children: [
                                      Container(
                                         padding:  EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                                        child: Image.network(document['image'],
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.fill,),

                                    ),
                                      Container(
                                      height: 100,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Container(
                                              child: Text(document['name'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16),),
                                            ),
                                          ),


                                          SizedBox(height: 10,),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                            child: Container(
                                              child: Text(document['discount']+" "+"EGP"+"      ",
                                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red[900],fontSize: 15)
                                              ),
                                            ),
                                          ),
                                          GetVendorName(value: document['venderid']),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            );


                          }).toList(),

                        ),),

                    ]),
              ),
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

          }),

    );
  }
  onItemPressed(
      index,
      ) async {
    switch (index) {
      case 0:
        print('go to person');

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Auth2()));

        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderShow()));

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
