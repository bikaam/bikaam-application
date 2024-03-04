
import 'package:bikaam/screens/show/Thanks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Cart.dart';

class Bill extends StatefulWidget {
  late String Total,Sum,CouponValue,X,name,address,phone;
  late List VendorList=[];
  Bill({required this.Total,required this.Sum, required this.CouponValue,required this.X,
    required this.name,required this.address,required this.phone,required this.VendorList});
  //const Bill({Key? key}) : super(key: key);

  @override
  State<Bill> createState() => _BillState(Total,Sum,CouponValue,X,name,address,phone,VendorList);
}

class _BillState extends State<Bill> {
  String Total,Sum,CouponValue,X,name,address,phone;
  late List VendorList=[];
  _BillState(this.Total,this.Sum,this.CouponValue,this.X,this.name,this.address,this.phone,this.VendorList);
//int x=int.parse(Total)-50;
  late int ordervendornum;
  getTime(){
    var data =DateTime.now();
    String Date=data.toString();
  }
  SendToVender(String dat) {
    for (var i = 0; i < VendorList.length; i++) {
      FirebaseAuth auth= FirebaseAuth.instance;
      String uid=auth.currentUser!.uid.toString();
      getTime();

      Map <String,dynamic> data={"name":name,"address":address
        ,"phone":phone,"state":"قيد المراجعة","userid":uid,"date":dat
      };
      FirebaseFirestore.instance.collection(VendorList[i]).doc("orders").collection("orders").doc(uid).set(data);
      final CollectionReference usersCollection = FirebaseFirestore.instance.collection(VendorList[i]);
      usersCollection.doc(VendorList[i]).get().then((value) {
        var fields = (value.data() as Map<String,dynamic>);
        setState(() {
          ordervendor = fields["orders"] ;
          print("ordervendor");
          print(ordervendor);
        });
      });
      ordervendornum=int.parse(ordervendor)+1;
      print("sum");
      print(ordervendornum);
      usersCollection
          .doc(VendorList[i]) // <-- Doc ID where data should be updated.
          .update(
          {
            'orders':ordervendornum.toString(),
          });
      print(VendorList[i]);
    }
  }
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection(uid).doc("orders").collection("orders");
    //int x=int.parse(Total.toString())-50;
    return Scaffold(
      //backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Center(child: Text("الفاتورة",style: TextStyle(color: Colors.white),)),
          elevation:5,
          backgroundColor: Colors.blue[900],

          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),

          ]
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
              body: ListView(
               // width: double.infinity,
               // height: double.infinity,
                //color: Colors.grey[100],
                children:[
                  Column(
                    children: [
                      SizedBox(height: 30,),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.blue[900],
                              size: 25,
                            ),
                            SizedBox(width: 15,),
                            Icon(
                              Icons.circle,
                              color: Colors.blue[900],
                              size: 10,
                            ),
                            SizedBox(width: 15,),
                            Icon(
                              Icons.circle,
                              color: Colors.blue[900],
                              size: 10,
                            ),
                            SizedBox(width: 15,),
                            Icon(
                              Icons.circle,
                              color: Colors.blue[900],
                              size: 10,
                            ),
                            SizedBox(width: 15,),
                            Icon(
                              Icons.circle,
                              color: Colors.blue[900],
                              size: 10,
                            ),
                            SizedBox(width: 15,),
                            Icon(
                              Icons.featured_play_list_outlined,
                              color: Colors.blue[900],
                              size: 25,
                            ),
                            SizedBox(width: 15,),
                            Icon(
                              Icons.circle,
                              color: Colors.grey[400],
                              size: 10,
                            ),
                            SizedBox(width: 15,),
                            Icon(
                              Icons.circle,
                              color: Colors.grey[400],
                              size: 10,
                            ),
                            SizedBox(width: 15,),
                            Icon(
                              Icons.circle,
                              color: Colors.grey[400],
                              size: 10,
                            ),
                            SizedBox(width: 15,),
                            Icon(
                              Icons.circle,
                              color: Colors.grey[400],
                              size: 10,
                            ),
                            SizedBox(width: 15,),
                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.grey[400],
                              size: 25,
                            ),
                            SizedBox(width: 15,),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          children: [
                            Text("المنتج ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                            SizedBox(width: 185,),
                            Text("المبلغ ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),

                          ],
                        ),
                      ),

                      Container(
                        width: 320,
                        height: 1,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10),
                          // color: Color(0xFFECF2FF),
                            border: Border.all(color: Colors.black12)
                        ),
                      ),
                      SizedBox(height: 5,),

                      Container(
                        height: 80,
                        child: ListView(

                          children: snapshot.data!.docs.map((document) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 7),
                              child: Container(
                                width: 350,

                                decoration: BoxDecoration(
                                    color: Colors.white
                                  // border: Border.all(color: Colors.black12)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(

                                    children: [
                                      Container(width:200, child: Text(document['name'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[700]),)),
                                     // SizedBox(width: 70,),
                                      Container(width:120,child: Center(child: Text(document['discount']+"جنية",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[700],fontSize: 13),))),
                                    ],
                                  ),
                                ),
                              ),

                            );

                          }).toList(),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          children: [
                            Container(width:200,child: Text("رسوم التوصيل : ",style: TextStyle(color: Colors.cyan[800],fontSize: 13,fontWeight: FontWeight.bold,),)),
                            //SizedBox(width: 80,),
                            Container(width:120,child: Center(child: Text("  50 جنية  ",style: TextStyle(color: Colors.cyan[800],fontWeight: FontWeight.bold,fontSize: 13),))),

                          ],
                        ),
                      ),

                      Container(
                        width: 320,
                        height: 1,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10),
                          // color: Color(0xFFECF2FF),
                            border: Border.all(color: Colors.black12)
                        ),
                      ),
                      SizedBox(height: 10,),



                      Container(
                        width: 320,
                        height: 120,


                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(width:200,child: Text("الاجمالي : ",style: TextStyle(color: Colors.blue[900]),)),
                                  //SizedBox(width: 150,),
                                  Container(width:120,child: Center(child: Text(Sum.toString()+" جنية  ",style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold,fontSize: 13),))),

                                ],
                              ),
                              Row(
                                children: [
                                  Container(width:200,child: Text("كوبون الخصم : ",style: TextStyle(color: Colors.blue[900]),)),
                                  //SizedBox(width: 155,),
                                  Container(width:120,child: Center(child: Text(CouponValue+" جنية  ",style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold,fontSize: 14),))),

                                ],
                              ),



                              Row(
                                children: [
                                  Container(width:200,child: Text("السعر بعد الخصم : ",style: TextStyle(color: Colors.blue[900]),)),
                                  //SizedBox(width: 155,),
                                  Container(width:120,child: Center(child: Text(Total.toString()+" جنية  ",style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold,fontSize: 14),))),

                                ],
                              ),
                              Container(
                                width: 320,
                                height: 2,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(10),
                                  // color: Color(0xFFECF2FF),
                                    border: Border.all(color: Colors.black12)
                                ),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(right: 0.0),
                                child: Row(
                                  children: [
                                    Container(width:200,child: Text("الاجمالي العام : ",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold,),)),
                                    //SizedBox(width: 80,),
                                    Container(width:120,child: Center(child: Text(X.toString()+" جنية  ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13),))),

                                  ],
                                ),
                              ),



                            ],
                          ),
                        ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: GestureDetector(
                          onTap: ()  {
                            var dat =DateTime.now();

                            String Date=dat.toString();
                            SendToVender(Date);
                            Map <String,dynamic> data={"name":name,"address":address
                              ,"phone":phone,"state":"قيد المراجعة","userid":uid,"date":Date
                            };
                            FirebaseFirestore.instance.collection("admin").doc("orders").collection("orders").doc(uid).set(data);
                            FirebaseFirestore.instance.collection(uid).doc("Cart").delete();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ThansPage()));
                            //FirebaseFirestore.instance.collection(uid).doc("orders").collection("orders").add(data);
                            //Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.red[900],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 1.0, // soften the shadow
                                  spreadRadius: 1.0, //extend the shadow
                                  offset: Offset(
                                    1.0, // Move to right 5  horizontally
                                    1.0, // Move to bottom 5 Vertically
                                  ),
                                )
                              ],
                            ),
                            child:
                            Center(child: Text("تأكيد الشراء",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),

                      Center(child: Image.asset('assets/images/logo.png',height: 100,)),





                    ]),]
              ),);
          }),

    );


  }
}
