import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/show/productdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../functions/discountshow.dart';
import '../../functions/pricedetails.dart';
import '../home/productdetailsnouser.dart';
class ListProducts extends StatefulWidget {
  late String value;
  ListProducts({required this.value});
  //const ListProducts({Key? key}) : super(key: key);

  @override
  State<ListProducts> createState() => _ListProductsState(value);
}

class _ListProductsState extends State<ListProducts> {
  String value;

  _ListProductsState(this.value);
  bool click= true;
  late FirebaseAuth _auth;
  late User? _user;

  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection(value).doc(
        "products").collection("products");
    return
        Container(
          height:500,
          child: StreamBuilder(
              stream: ref.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    'no values', style: TextStyle(color: Colors.black),);
                }
                return     GridView(
                  shrinkWrap: true,
                  //physics: BouncingScrollPhysics(),

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          mainAxisExtent: 250,
                        ),
                        children: snapshot.data!.docs.map((document) {
                          return
                            GestureDetector(
                              onTap: () {
                                print(document["Colors"]);
                                List Cool = document['Colors'];
                                _auth = FirebaseAuth.instance;
                                _user = _auth.currentUser;
                                if (_user == null) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          ProductItemScreenNoUser(
                                            name: document['name'],
                                            price: document['price'],
                                            discount: document['discount'],
                                            about: document['about'],
                                            after: document['after'].toString(),
                                            image: document['imageUrl'],
                                            venderid: document['uid'],
                                            category: document['category'],
                                            Colorss: document['Colors'],
                                            Sizes: document['Sizes'],
                                            shopname: document['shopname'],
                                            cashback: document['cashback'],

                                          ))
                                  );
                                }
                                else {
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  String uid = auth.currentUser!.uid.toString();
                                  for (int i = 0; i < Cool.length; i++) {
                                    Map <String, dynamic> data = {
                                      'color': Cool[i],
                                      "isSelected": false
                                    };
                                    FirebaseFirestore.instance.collection(uid).doc(
                                        "Colors").collection("Colors")
                                        .doc(Cool[i])
                                        .set(data);
                                  }
                                  List Siz = document['Sizes'];

                                  for (int i = 0; i < Siz.length; i++) {
                                    Map <String, dynamic> data = {
                                      'size': Siz[i],
                                      "isSelected": false
                                    };
                                    FirebaseFirestore.instance.collection(uid).doc(
                                        "Sizes").collection("Sizes").doc(Siz[i]).set(
                                        data);
                                  }


                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          ProductItemScreen(name: document['name'],
                                            price: document['price'],
                                            discount: document['discount'],
                                            about: document['about'],
                                            after: document['after'].toString(),
                                            image: document['imageUrl'],
                                            venderid: document['uid'],
                                            category: document['category'],
                                            Colorss: document['Colors'],
                                            Sizes: document['Sizes'],
                                            shopname: document['shopname'],
                                            cashback: document['cashback'],

                                          ))
                                  );
                                }
                              },
                              child: Container(
                                height: double.infinity,
                                width: 154,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding / 2),
                                decoration: BoxDecoration(
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
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(width: defaultPadding / 4),

                                        /* Text(
                                                    document["discount"],
                                                    style: const TextStyle(color: Colors.red),
                                                  ), */


                                      ],
                                    ),
                                    PriceDetails(price: document['price'],
                                        discount: document['discount'],
                                        after: document['after'].toString(),
                                        cashback: document['cashback'])

                                  ],
                                ),
                              ),
                            );
                        }).toList(),


                      ) ;
                /*   SliverGrid(
                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2,
                         crossAxisSpacing: 5,
                         mainAxisSpacing: 5,
                         mainAxisExtent: 250,
                       ),
                       delegate: SliverChildBuilderDelegate(
                           (context,index){
                             return GestureDetector(
                               onTap: () {
                              /*   print(

                                     document["Colors"]
                                 );
                                 List Cool = document['Colors'];
                                 _auth = FirebaseAuth.instance;
                                 _user = _auth.currentUser;
                                 if (_user == null) {
                                   Navigator.push(context,
                                       MaterialPageRoute(builder: (context) =>
                                           ProductItemScreenNoUser(
                                             name: document['name'],
                                             price: document['price'],
                                             discount: document['discount'],
                                             about: document['about'],
                                             after: document['after'].toString(),
                                             image: document['imageUrl'],
                                             venderid: document['uid'],
                                             category: document['category'],
                                             Colorss: document['Colors'],
                                             Sizes: document['Sizes'],
                                             shopname: document['shopname'],
                                             cashback: document['cashback'],

                                           ))
                                   );
                                 }
                                 else {
                                   FirebaseAuth auth = FirebaseAuth.instance;
                                   String uid = auth.currentUser!.uid.toString();
                                   for (int i = 0; i < Cool.length; i++) {
                                     Map <String, dynamic> data = {
                                       'color': Cool[i],
                                       "isSelected": false
                                     };
                                     FirebaseFirestore.instance.collection(uid).doc(
                                         "Colors").collection("Colors")
                                         .doc(Cool[i])
                                         .set(data);
                                   }
                                   List Siz = document['Sizes'];

                                   for (int i = 0; i < Siz.length; i++) {
                                     Map <String, dynamic> data = {
                                       'size': Siz[i],
                                       "isSelected": false
                                     };
                                     FirebaseFirestore.instance.collection(uid).doc(
                                         "Sizes").collection("Sizes").doc(Siz[i]).set(
                                         data);
                                   }


                                   Navigator.push(context,
                                       MaterialPageRoute(builder: (context) =>
                                           ProductItemScreen(name: document['name'],
                                             price: document['price'],
                                             discount: document['discount'],
                                             about: document['about'],
                                             after: document['after'].toString(),
                                             image: document['imageUrl'],
                                             venderid: document['uid'],
                                             category: document['category'],
                                             Colorss: document['Colors'],
                                             Sizes: document['Sizes'],
                                             shopname: document['shopname'],
                                             cashback: document['cashback'],

                                           ))
                                   );
                                 } */
                               },
                               child: Container(
                                 height: double.infinity,
                                 width: 154,
                                 padding: const EdgeInsets.symmetric(
                                     horizontal: defaultPadding / 2),
                                 decoration: BoxDecoration(
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
                                           child: Image.network(
                                             '${snapshot.data!.docs[index]['imageUrl']}',

                                           //  document['imageUrl'],
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
                                             '${snapshot.data!.docs[index]['name']}',

                                            // document['name'],
                                             style: const TextStyle(
                                                 color: Colors.black),
                                           ),
                                         ),
                                         const SizedBox(width: defaultPadding / 4),

                                         /* Text(
                                                    document["discount"],
                                                    style: const TextStyle(color: Colors.red),
                                                  ), */


                                       ],
                                     ),
                                     PriceDetails(price: '${snapshot.data!.docs[index]['price']}',
                                         discount: '${snapshot.data!.docs[index]['discount']}',
                                         //document['discount'],
                                         after: '${snapshot.data!.docs[index]['after']}',  //document['after'].toString(),
                                         cashback: '${snapshot.data!.docs[index]['cashback']}',// document['cashback'])

                                   ),
                                 ]),
                               ),
                             );
                           }
                       ) ) ;*/
                 /*   GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          mainAxisExtent: 250,
                        ),
                        children: snapshot.data!.docs.map((document) {
                          return
                            GestureDetector(
                              onTap: () {
                                print(document["Colors"]);
                                List Cool = document['Colors'];
                                _auth = FirebaseAuth.instance;
                                _user = _auth.currentUser;
                                if (_user == null) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          ProductItemScreenNoUser(
                                            name: document['name'],
                                            price: document['price'],
                                            discount: document['discount'],
                                            about: document['about'],
                                            after: document['after'].toString(),
                                            image: document['imageUrl'],
                                            venderid: document['uid'],
                                            category: document['category'],
                                            Colorss: document['Colors'],
                                            Sizes: document['Sizes'],
                                            shopname: document['shopname'],
                                            cashback: document['cashback'],

                                          ))
                                  );
                                }
                                else {
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  String uid = auth.currentUser!.uid.toString();
                                  for (int i = 0; i < Cool.length; i++) {
                                    Map <String, dynamic> data = {
                                      'color': Cool[i],
                                      "isSelected": false
                                    };
                                    FirebaseFirestore.instance.collection(uid).doc(
                                        "Colors").collection("Colors")
                                        .doc(Cool[i])
                                        .set(data);
                                  }
                                  List Siz = document['Sizes'];

                                  for (int i = 0; i < Siz.length; i++) {
                                    Map <String, dynamic> data = {
                                      'size': Siz[i],
                                      "isSelected": false
                                    };
                                    FirebaseFirestore.instance.collection(uid).doc(
                                        "Sizes").collection("Sizes").doc(Siz[i]).set(
                                        data);
                                  }


                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          ProductItemScreen(name: document['name'],
                                            price: document['price'],
                                            discount: document['discount'],
                                            about: document['about'],
                                            after: document['after'].toString(),
                                            image: document['imageUrl'],
                                            venderid: document['uid'],
                                            category: document['category'],
                                            Colorss: document['Colors'],
                                            Sizes: document['Sizes'],
                                            shopname: document['shopname'],
                                            cashback: document['cashback'],

                                          ))
                                  );
                                }
                              },
                              child: Container(
                                height: double.infinity,
                                width: 154,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding / 2),
                                decoration: BoxDecoration(
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
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(width: defaultPadding / 4),

                                        /* Text(
                                                    document["discount"],
                                                    style: const TextStyle(color: Colors.red),
                                                  ), */


                                      ],
                                    ),
                                    PriceDetails(price: document['price'],
                                        discount: document['discount'],
                                        after: document['after'].toString(),
                                        cashback: document['cashback'])

                                  ],
                                ),
                              ),
                            );
                        }).toList(),


                      ) */
                    }),
        );
            }




  }


/*
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
*/
