import 'package:bikaam/screens/home/components/addproducts.dart';
import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/home/venderpage.dart';
import 'package:bikaam/screens/show/productdetail.dart';
import 'package:bikaam/screens/usedproduct/homepage/showproductdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../functions/discountshow.dart';
import '../../../functions/pricedetails.dart';
import 'Cart.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  
  late String image;

  @override

  int sum=0;

  Widget build(BuildContext context) {

    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection(uid).doc('orders').collection("likes");
    //int curentIndex=0;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        //backgroundColor: Colors.grey,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [


            const SizedBox(width: defaultPadding / 2),
            Text(
              "المنتجات المفضلة",
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
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Container(
                  child: Text(
                    'لا يوجد بيانات',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              );
            }

            return GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent:270,
              ),
              children: snapshot.data!.docs.map((document) {
                return
                  Container(
                    child: GestureDetector(
                      onTap:(){
                        //print(document["Colors"]);

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context)=>ProductItemScreen(name:document['name'],price: document['price'],
                              about:document['about'],image:document['image'],
                              venderid:document['venderid'],category:document['category'],Colorss: document['colors'],
                              Sizes: document['sizes'], shopname: document['shopname'], cashback: document['cashback'],discount: document['discount'], after: document['after'],

                            ))
                        );
                      },
                      child: Container(
                        height: double.infinity,
                        width: 154,
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2,vertical: 5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(
                              defaultBorderRadius)),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(defaultBorderRadius)),
                                  ),
                                  child: Image.network(document['image'],
                                    height: 180,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                // ShowDiscount(value: document['discount'],),
                                //FavButton(value:document['name'])


                              ],
                            ),
                            const SizedBox(height: defaultPadding / 2),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      document['name'],
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(width: defaultPadding / 4),

                                  /* Text(
                                      document["discount"],
                                      style: const TextStyle(color: Colors.red),
                                    ), */


                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    document['price']+" EGP",
                                    style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text("ShopName:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Text(
                                      document['shopname']+"   ",
                                      style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.bold,fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //  PriceDetails(price: document['price'],discount: document['discount'],after: document['after'].toString(),cashback:document['cashback'])

                          ],
                        ),
                      ),
                    ),
                  );



              }).toList(),


            );
          }),
      /*    bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          color: Colors.blue,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.redAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 10),
          items: items,
          height: 50,
          index: index,
          onTap: onItemPressed,

          //   onTap: (index) => ,
        ),
      ), */
    );
  }

}