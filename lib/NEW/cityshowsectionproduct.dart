import 'package:bikaam/screens/show/productdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../functions/discountshow.dart';
import '../../functions/pricedetails.dart';
import '../screens/home/productdetailsnouser.dart';
class CitySectionProduct extends StatefulWidget {
  late String value;late String section;

  CitySectionProduct({required this.value,required this.section});
  //const CitySectionProduct({Key? key}) : super(key: key);

  @override
  State<CitySectionProduct> createState() => _CitySectionProductState(value,section);
}

class _CitySectionProductState extends State<CitySectionProduct> {
  String value,section;
  _CitySectionProductState(this.value,this.section);
  late FirebaseAuth _auth;
  late User? _user;
  @override
  Widget build(BuildContext context) {

    CollectionReference ref= FirebaseFirestore.instance.collection(value).doc("sections").collection("Sections").doc(section).collection(section);
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
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(

                            onTap:(){
                              print(document["Colors"]);
                              List Cool=document['Colors'];
                              _auth = FirebaseAuth.instance;
                              _user = _auth.currentUser;
                              if(_user==null) {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (BuildContext context)=>ProductItemScreenNoUser(name:document['name'],price: document['price'],
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


                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (BuildContext context)=>ProductItemScreen(name:document['name'],price: document['price'],
                                      discount:document['discount'],about:document['about'],after:document['after'].toString(),
                                      image:document['imageUrl'],venderid:document['uid'],category:document['category'],Colorss: document['Colors'],
                                      Sizes: document['Sizes'], shopname: document['shopname'], cashback: document['cashback'],

                                    ))
                                );
                              }

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.network( document['imageUrl'],
                                      height: 150,
                                      width: 170,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  //SizedBox(height:10),
                                  Container(
                                    width: 170,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                      child: Row(
                                        children: [
                                          Text(document['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 170,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Text(document['about'],style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: 10),),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Row(
                                      children: [

                                        Text(
                                          document['discount'].toString()+" EGP",
                                          style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13),
                                        ),

                                        const SizedBox(width: defaultPadding/2 ),
                                        Text("بدلا من "),
                                        const SizedBox(width: defaultPadding /2),
                                        Text(
                                            document['price'] +" EGP",

                                            style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 13,decoration: TextDecoration.lineThrough)
                                        ),
                                      ],
                                    ),
                                  ),

                                  // PriceDetails(price: document['price'],discount: document['discount'],after: document['after'].toString(),cashback:document['cashback']),


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
