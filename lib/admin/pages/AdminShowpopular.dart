import 'package:bikaam/screens/show/productdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../functions/discountshow.dart';
import '../../functions/pricedetails.dart';
class AdminListProduct extends StatefulWidget {



  @override
  State<AdminListProduct> createState() => _AdminListProductState();
}

class _AdminListProductState extends State<AdminListProduct> {

  @override
  Widget build(BuildContext context) {

    CollectionReference ref= FirebaseFirestore.instance.collection("admin").doc("popularproducts").collection("popularproducts");
    return
      Container(
        height:260,
        //width: 200,

        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black12),
          color: Colors.white,
        ),
        //width: 300,
        child: StreamBuilder(
            stream:ref.snapshots(),
            builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('no values', style: TextStyle(color: Colors.black),);
              }
              return GestureDetector(
                //onTap: goToCat,
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    children: snapshot.data!.docs.map((document) {
                      return
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(

                            onTap:(){
                              print(document["Colors"]);

                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context)=>ProductItemScreen(name:document['name'],price: document['price'],
                                    discount:document['discount'],about:document['about'],after:document['after'].toString(),
                                    image:document['imageUrl'],venderid:document['uid'],category:document['category'],Colorss: document['Colors'],
                                    Sizes: document['Sizes'], shopname: document['shopname'], cashback: document['cashback'],
                                  ))
                              );
                            },
                            child: Container(
                              height: double.infinity,
                              width: 170,
                              padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                              decoration: BoxDecoration(
                                //border: Border.all(color: ),
                                //color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(
                                   20)),
                                border: Border.all(color: Colors.black12)
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: bgColor,
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(defaultBorderRadius)),
                                          ),
                                          child: Image.network(document['imageUrl'],
                                            height: 170,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      ShowDiscount(value: document['discount'],),
                                      //FavButton(value:document['name'])


                                    ],
                                  ),
                                  const SizedBox(height: defaultPadding / 2),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          document['name'],
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    //  const SizedBox(width: defaultPadding),




                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  PriceDetails(price: document['price'],discount: document['discount'],after: document['after'].toString(),cashback:document['cashback']),


                                ],
                              ),
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

