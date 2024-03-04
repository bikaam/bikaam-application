import 'package:bikaam/screens/show/productdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants.dart';
import '../../functions/pricedetails.dart';
import '../home/productdetailsnouser.dart';
class ShowCatProducts extends StatefulWidget {
  late String value,venderId;

  ShowCatProducts({required this.value,required this.venderId});

  //const ShowCatProducts({Key? key}) : super(key: key);

  @override
  State<ShowCatProducts> createState() => _ShowCatProductsState(value,venderId);
}

class _ShowCatProductsState extends State<ShowCatProducts> {
  String value,venderId;

  _ShowCatProductsState(this.value,this.venderId);
  late FirebaseAuth _auth;
  late User? _user;
  @override
  Widget build(BuildContext context) {
    //FirebaseAuth auth = FirebaseAuth.instance;
   // String uid = auth.currentUser!.uid.toString();

    CollectionReference ref = FirebaseFirestore.instance.collection(venderId).doc("categories").collection(value);
    return Container(
      height: 670,
      child: StreamBuilder(
          stream: ref.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text(
                'no values', style: TextStyle(color: Colors.black),);
            }
            return
              Container(
                // height: 590,
                //width: 300,
                child: StreamBuilder(
                    stream: ref.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          'no values', style: TextStyle(color: Colors.black),);
                      }
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          mainAxisExtent:250,
                        ),
                        children: snapshot.data!.docs.map((document) {
                          return
                            GestureDetector(
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
                                height: double.infinity,
                                width: 154,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding / 2),
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
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(defaultBorderRadius)),
                                          ),
                                          child: Image.network(document['imageUrl'],
                                            height: 170,
                                            width: 100,
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
                            );



                        }).toList(),


                      );
                    }


                ),
              );


          }


      ),
    );
      // Container(
      //   height: 260,
      //   //width: 300,
      //   child:
      //   StreamBuilder(
      //       stream: ref.snapshots(),
      //       builder: (BuildContext context,
      //           AsyncSnapshot<QuerySnapshot> snapshot) {
      //         if (!snapshot.hasData) {
      //           return Text(
      //             'no values', style: TextStyle(color: Colors.black),);
      //         }
      //         return GestureDetector(
      //           // onTap: goToCat,
      //           child: Container(
      //             //width: 270,
      //             // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      //             child: ListView(
      //               scrollDirection: Axis.horizontal,
      //               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      //               children: snapshot.data!.docs.map((document) {
      //                 return
      //
      //                   Padding(
      //                     padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 2),
      //                     child: GestureDetector(
      //                       onTap:(){
      //                         print(document["Colors"]);
      //                         List Cool=document['Colors'];
      //                         _auth = FirebaseAuth.instance;
      //                         _user = _auth.currentUser;
      //                         if(_user==null) {
      //                           Navigator.of(context).pushReplacement(MaterialPageRoute(
      //                               builder: (BuildContext context)=>ProductItemScreenNoUser(name:document['name'],price: document['price'],
      //                                 discount:document['discount'],about:document['about'],after:document['after'].toString(),
      //                                 image:document['imageUrl'],venderid:document['uid'],category:document['category'],Colorss: document['Colors'],
      //                                 Sizes: document['Sizes'], shopname: document['shopname'], cashback: document['cashback'],
      //
      //                               ))
      //                           );
      //                         }
      //                         else{
      //                           FirebaseAuth auth= FirebaseAuth.instance;
      //                           String uid=auth.currentUser!.uid.toString();
      //                           for(int i=0;i<Cool.length;i++){
      //                             Map <String,dynamic> data={'color':Cool[i],"isSelected":false};
      //                             FirebaseFirestore.instance.collection(uid).doc("Colors").collection("Colors").doc(Cool[i]).set(data);
      //
      //                           }
      //                           List Siz=document['Sizes'];
      //
      //                           for(int i=0;i<Siz.length;i++){
      //                             Map <String,dynamic> data={'size':Siz[i],"isSelected":false};
      //                             FirebaseFirestore.instance.collection(uid).doc("Sizes").collection("Sizes").doc(Siz[i]).set(data);
      //
      //                           }
      //
      //
      //                           Navigator.of(context).pushReplacement(MaterialPageRoute(
      //                               builder: (BuildContext context)=>ProductItemScreen(name:document['name'],price: document['price'],
      //                                 discount:document['discount'],about:document['about'],after:document['after'].toString(),
      //                                 image:document['imageUrl'],venderid:document['uid'],category:document['category'],Colorss: document['Colors'],
      //                                 Sizes: document['Sizes'], shopname: document['shopname'], cashback: document['cashback'],
      //
      //                               ))
      //                           );
      //                         }
      //                       },
      //                       child: Container(
      //                         //height: double.infinity,
      //                         width: 190,
      //                         //padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      //                         decoration:  BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.circular(10),
      //                           border: Border.all(color: Colors.black12),
      //                         ),
      //                         child: Column(
      //                           children: [
      //                             Stack(
      //                               children: [
      //                                 Container(
      //                                   width: double.infinity,
      //                                   decoration: BoxDecoration(
      //                                     color: bgColor,
      //                                     borderRadius: const BorderRadius.all(Radius.circular(defaultBorderRadius)),
      //                                   ),
      //                                   child: Image.network(document['imageUrl'],
      //                                     height: 170,
      //                                     width: 110,
      //                                     fit: BoxFit.cover,
      //                                   ),
      //                                 ),
      //
      //                                 //ShowDiscount(value: document['discount'],),
      //                                 //FavButton(value:document['name'])
      //
      //
      //                               ],
      //                             ),
      //                             const SizedBox(height: defaultPadding / 2),
      //                             Row(
      //                               children: [
      //                                 Expanded(
      //                                   child: Text(
      //                                     document['name'],
      //                                     style: const TextStyle(color: Colors.black),
      //                                   ),
      //                                 ),
      //                                 const SizedBox(width: defaultPadding / 4),
      //
      //                                 /* Text(
      //                               document["discount"],
      //                               style: const TextStyle(color: Colors.red),
      //                             ), */
      //
      //
      //                               ],
      //                             ),
      //                             PriceDetails(price: document['price'],discount: document['discount'],after: document['after'].toString(),cashback:document['cashback'])
      //
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                   );
      //
      //               }
      //               ).toList(),
      //             ),
      //           ),
      //         );
      //       }
      //
      //
      //   ),
      // );
  }
}

/*
      Container(
        height: 590,
        //width: 300,
        child: StreamBuilder(
            stream: ref.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text(
                  'no values', style: TextStyle(color: Colors.black),);
              }
              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  mainAxisExtent:250,
                ),
                children: snapshot.data!.docs.map((document) {
                  return
                    GestureDetector(
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
                        height: double.infinity,
                        width: 154,
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
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
                                  child: Image.network(document['imageUrl'],
                                    height: 170,
                                    width: 100,
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
                    );



                }).toList(),


              );
            }


        ),
      );

* */
