import 'package:bikaam/screens/show/productdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../constants.dart';
import '../../functions/discountshow.dart';
import '../../functions/pricedetails.dart';
import '../screens/home/productdetailsnouser.dart';
import '../screens/show/Cart.dart';
class ProductTimer extends StatefulWidget {


  @override
  State<ProductTimer> createState() => _ProductTimerState();
}

class _ProductTimerState extends State<ProductTimer> {
  int sum=0;
  late String cart;
  void getUsersData(value) {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection(uid);
    usersCollection.doc(uid).get().then((value) {
      var fields = (value.data() as Map<String,dynamic>);
      setState(() {
        cart = fields["cartnum"] ;
        print(cart);
      });
    });

    sum=int.parse(cart)+1;
    print("sum");
    print(sum);
    usersCollection
        .doc(value) // <-- Doc ID where data should be updated.
        .update(
        {
          'cartnum':sum.toString(),
        });
  }

  @override
  Widget build(BuildContext context) {
    late FirebaseAuth _auth;
    late User? _user;
    CollectionReference ref= FirebaseFirestore.instance.collection("admin").doc("products").collection("Timer");
    return
      Container(
        height:300,
        width: 200,

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
                              width: 200,
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
                                      Positioned(
                                        top: 150,
                                        left: 10,

                                        child: SlideCountdown(
                                        duration:Duration(days:int.parse(document["time"])),
                                        //padding: defaultPadding,
                                        slideDirection: SlideDirection.up,
                                        //countUp: true,
                                       // separatorType: SeparatorType.title,
                                        textStyle: TextStyle(fontSize: 15,color: Colors.black),
                                        decoration: BoxDecoration(
                                          color: Colors.white54,
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                        ),
                                      ),)
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
                                  InkWell(
                                    onTap: (){
                                      Map <String,dynamic> data={"name":document['name'],"price":document['price'],"discount":document['discount'],
                                        "imageUrl":document['imageUrl'],"category":document['category'],"about":document['about'],"after":document['after'],
                                        "uid":"admin","Colors":document['Colors'],"size":document['Sizes'],'cashback':document['cashback'],"isSelected":false
                                      };
                                      FirebaseAuth auth= FirebaseAuth.instance;
                                      String uid=auth.currentUser!.uid.toString();
                                      FirebaseFirestore.instance.collection(uid).doc("Cart").collection("Cart").doc(document['name']).set(data);
                                      getUsersData(uid);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 120,
                                      color: Colors.red,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text("  اضافة الي السلة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                  )

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

