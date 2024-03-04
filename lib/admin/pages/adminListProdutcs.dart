import 'package:bikaam/screens/show/productdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../screens/usedproduct/homepage/showproductdetails.dart';
class AdminShowListProduct extends StatefulWidget {

  @override
  State<AdminShowListProduct> createState() => _AdminShowListProductState();
}

class _AdminShowListProductState extends State<AdminShowListProduct> {
  //String value,venderid;
  //_ShowListProductState(this.value,this.venderid);
  @override
  Widget build(BuildContext context) {

    CollectionReference ref= FirebaseFirestore.instance.collection('admin').doc("popularusedproducts").collection("popularusedproducts");
    return
      Container(
        height:250,

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
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    children: snapshot.data!.docs.map((document) {
                      return
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(

                            onTap:(){
                              print(document["Colors"]);

                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context)=>ShowUsedDetails(name:document['name'],price: document['price'],
                                   about:document['about'],
                                    image:document['imageUrl'],venderid:document['uid'],category:document['category'],Colorss: document['Colors'],
                                    Sizes: document['Sizes'], address:document['address'], phone: document['phone'], vendorname: document['sellername'] ,
                                  ))
                              );
                            },
                            child: Container(
                              height: double.infinity,
                              width: 154,
                              padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(
                                    defaultBorderRadius)),
                              ),
                              child: Column(
                                children: [
                                  Container(
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
                                  Row(
                                    children: [

                                      Text(
                                        document["price"]+" EGP",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[900]),

                                      ),

                                     // const SizedBox(width: defaultPadding ),

                                    ],
                                  ),

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

