import 'package:bikaam/screens/show/productdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../functions/pricedetails.dart';
import '../home/productdetailsnouser.dart';
class ShowListProduct extends StatefulWidget {
  late String value,venderid;
  ShowListProduct({required this.value,required this.venderid});
  //const ShowListProduct({Key? key}) : super(key: key);

  @override
  State<ShowListProduct> createState() => _ShowListProductState(value,venderid);
}

class _ShowListProductState extends State<ShowListProduct> {
  String value,venderid;
  _ShowListProductState(this.value,this.venderid);
  late FirebaseAuth _auth;
  late User? _user;
  @override
  Widget build(BuildContext context) {

    CollectionReference ref= FirebaseFirestore.instance.collection(venderid).doc("categories").collection(value);
    return
      Container(
        height:250,
        //width: 320,

        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black12),
         // color: Colors.white,
        ),
        //width: 300,
        child: StreamBuilder(
            stream:ref.snapshots(),
            builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('no values', style: TextStyle(color: Colors.black),);
              }
              return GestureDetector(
                // onTap: goToCat,
                child: Container(
                  //width: 270,
                  // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    children: snapshot.data!.docs.map((document) {
                      return

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2),
                          child: GestureDetector(
                            onTap:(){
                              print(document["Colors"]);
                              List Cool=document['Colors'];
                              _auth = FirebaseAuth.instance;
                              _user = _auth.currentUser;
                              if(_user==null) {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductItemScreenNoUser(name:document['name'],price: document['price'],
                                      discount:document['discount'],about:document['about'],after:document['after'].toString(),
                                      image:document['imageUrl'],venderid:document['uid'],category:document['category'],Colorss: document['Colors'],
                                      Sizes: document['Sizes'], shopname: document['shopname'], cashback: document['cashback'],

                                    ))
                                );
                              }
                              else{
                                FirebaseAuth auth= FirebaseAuth.instance;
                                String uid=auth.currentUser!.uid.toString();
                                for(int i=0;i<Cool.length;i++){
                                  Map <String,dynamic> data={'color':Cool[i],"isSelected":false};
                                  FirebaseFirestore.instance.collection(uid).doc("Colors").collection("Colors").doc(Cool[i]).set(data);

                                }
                                List Siz=document['Sizes'];

                                for(int i=0;i<Siz.length;i++){
                                  Map <String,dynamic> data={'size':Siz[i],"isSelected":false};
                                  FirebaseFirestore.instance.collection(uid).doc("Sizes").collection("Sizes").doc(Siz[i]).set(data);

                                }


                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductItemScreen(name:document['name'],price: document['price'],
                                      discount:document['discount'],about:document['about'],after:document['after'].toString(),
                                      image:document['imageUrl'],venderid:document['uid'],category:document['category'],Colorss: document['Colors'],
                                      Sizes: document['Sizes'], shopname: document['shopname'], cashback: document['cashback'],

                                    ))
                                );
                              }
                            },
                            child: Container(
                              //height: double.infinity,
                              width: 190,
                              //padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                              decoration:  BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: bgColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(defaultBorderRadius)),
                                        ),
                                        child: Image.network(document['imageUrl'],
                                          height: 170,
                                          width: 110,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      //ShowDiscount(value: document['discount'],),
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
                                      const SizedBox(width: defaultPadding / 4),

                                      /* Text(
                                    document["discount"],
                                    style: const TextStyle(color: Colors.red),
                                  ), */


                                    ],
                                  ),
                                  PriceDetails(price: document['price'],discount: document['discount'],after: document['after'].toString(),cashback:document['cashback'])

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

