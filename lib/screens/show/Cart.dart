import 'package:bikaam/screens/show/orderinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../functions/pricedetails.dart';
String cartnum="0";
String ordervendor="0";
bool iscash=false;
class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int _counter = 1;

  bool wallet= false;

  get isSelected => null;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  double sum=0;
  void _incrementSun(value) {

      sum=double.parse(value)+sum;
      print("///////////////////////");
      print(sum);

  }

  void _discrementCounter() {
    setState(() {
      _counter = _counter - 1;
    });
  }
  //double sum=0;
   List<double> Sum=[];
  Calculate(discount){
    double sum=0;
    sum=double.parse(discount)+sum;
    print(sum);
    //Sum.add(sum);
    //print(Sum);
  }

  List <String> venderid= [];
  AddVenderid(Vid){
    venderid.add(Vid);
    print(venderid);
  }
  getTime(){
    var data =DateTime.now();
    String Date=data.toString();
  }

  late int ordervendornum;

  SendToVender(String dat) {
    for (var i = 0; i < venderid.length; i++) {
      FirebaseAuth auth= FirebaseAuth.instance;
      String uid=auth.currentUser!.uid.toString();
      getTime();

      Map <String,dynamic> data={"name":_name.text,"address":_address.text
        ,"phone":_phone.text,"state":"قيد المراجعة","userid":uid,"date":dat
      };
      FirebaseFirestore.instance.collection(venderid[i]).doc("orders").collection("orders").doc(uid).set(data);
      final CollectionReference usersCollection = FirebaseFirestore.instance.collection(venderid[i]);
      usersCollection.doc(venderid[i]).get().then((value) {
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
          .doc(venderid[i]) // <-- Doc ID where data should be updated.
          .update(
          {
            'orders':ordervendornum.toString(),
          });
      print(venderid[i]);
    }
  }

  List <String> Price= [];
  double s = 0;
  AddPrice(discount){
    Price.add(discount);
    print(Price);
    s=double.parse(discount)+s;
    total=s;

  }
  deleteSum(discount){
    s=s-double.parse(discount);
    total=s;
  }

  double x =0;

  late int count;
  Future<int> getCount() async {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
     count = await FirebaseFirestore.instance
        .collection(uid).doc('Cart').collection("Cart")
        .get()
        .then((value) => value.size);
    print(count);
    return count;
  }
   int sum1 =0;
  void getUsersData() {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection(uid);
    usersCollection.doc(uid).get().then((value) {
      var fields = (value.data() as Map<String,dynamic>);
      setState(() {
        cartnum = fields["cartnum"] ;
        print(cartnum);
      });
    });
    sum1=int.parse(cartnum)-1;
    print("sum");
    print(sum1);
    usersCollection
        .doc(uid) // <-- Doc ID where data should be updated.
        .update(
        {
          'cartnum':sum1.toString(),
        });
  }

String usercashback="0";
  void getUserscashback() {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection(uid);
    usersCollection.doc(uid).get().then((value) {
      var fields = (value.data() as Map<String,dynamic>);
      setState(() {
        usercashback = fields["cashback"] ;
        print(usercashback);
      });
    });

  }

  String cashback="0";
  void getCategoryCashback(String category,String vendorid) {

    final CollectionReference usersCollection = FirebaseFirestore.instance.collection(vendorid).doc("categories").collection("Categories");
    usersCollection.doc(category).get().then((value) {
      var fields = (value.data() as Map<String,dynamic>);
      setState(() {
        cashback = fields["cashback"] ;
        print(cashback);
      });
    });

  }

  late String ordern;
  int ordernum=0;
  void getordernum() {
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection("admin").doc("ordersnum").collection("ordersnum");
    usersCollection.doc("orders").get().then((value) {
      var fields = (value.data() as Map<String,dynamic>);
      setState(() {
        ordern = fields["value"] ;
        print("ordernum");
        print(ordern);
      });
    });
    ordernum=int.parse(ordern)+1;
    print("sum");
    print(ordernum);
    usersCollection
        .doc("orders") // <-- Doc ID where data should be updated.
        .update(
        {
          'value':ordernum.toString(),
        });
  }

  late String couponinfo;
   String couponvalues="0";
  String valueofCoupon="0";
  double total= 0;

  final _coupon=TextEditingController();


  Future<void> getCouponInfo() async {
    final Coupon = FirebaseFirestore.instance.collection("Coupons").doc(_coupon.text);


    if (((await Coupon.get())!.exists)) {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection("Coupons");
 /* usersCollection.doc(_coupon.text).get().then((value) {
  var fields = (value.data() as Map<String,dynamic>);
  setState(() {
  couponinfo = fields["coupontype"] ;
  });
  print(couponinfo);
  });*/
  usersCollection.doc(_coupon.text).get().then((value) {
    var fields = (value.data() as Map<String,dynamic>);
    setState(() {
      couponvalues = fields["couponValue"] ;
      total=s-int.parse(couponvalues);

      valueofCoupon=couponvalues;
    //  total=s-int.parse(couponvalues);

    });
    print(couponvalues);
  });

    setState(() {
     // total=s-int.parse(valueofCoupon);
    });


  }
    else{
      var altertDialog = AlertDialog(



        content:
        Container(
            height: 30,
            child:
            Center(child: Text("حدث خطا"),)
        ),



      );
      showDialog(context: context, builder: (BuildContext context)
      {
        return altertDialog;
      });
    }

  }

  final _name=TextEditingController();
  final _phone=TextEditingController();
  final _address=TextEditingController();
  final _code=TextEditingController();

  String _check="not";
  bool click=true;

  int index=1;



  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    CollectionReference ref = FirebaseFirestore.instance.collection(uid).doc("Cart").collection("Cart");
    var data =DateTime.now();

    // double sum = 0.0;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Text("سلة التسوق",style: TextStyle(color: Colors.black),),
          elevation:5,
          backgroundColor: Colors.white,

          actions: <Widget>[
            //Text("سلة التسوق",style: TextStyle(color: Colors.black),),
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
              body: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[100],
                child: Column(
                    children: [
                      SizedBox(height: 10,),

                      Expanded(
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
                                child: Row(

                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        String Date=data.toString();
                                        bool val=document['isSelected'];

                                        setState(() {
                                          bool val=document['isSelected'];
                                          val= !val;
                                          if (val == true) {
                                            ref.doc(document['name']) // <-- Doc ID where data should be updated.
                                                .update(
                                                {
                                                  'isSelected':true,
                                                });
                                            AddVenderid(document['uid']);
                                            AddPrice(document['discount']);

                                            print(document["name"]);
                                            FirebaseAuth auth= FirebaseAuth.instance;
                                            String uid=auth.currentUser!.uid.toString();
                                            Map <String,dynamic> data={"name": document['name'],"venderid":document["uid"],'image':document["imageUrl"],
                                              'price':document['price'],"discount":document['discount'],
                                              "date":Date
                                            };
                                            FirebaseFirestore.instance.collection(uid).doc("orders").collection("orders").doc(document['name']).set(data);
                                            FirebaseFirestore.instance.collection(uid).doc("orders").collection(document["uid"]).doc(document['name']).set(data);
                                            getUserscashback();

                                            if(document['cashback']!="0")
                                            {
                                              print(document['cashback']);
                                             // getUserscashback();
                                              final CollectionReference usersCollection = FirebaseFirestore.instance.collection(uid);
                                              int cash= int.parse(usercashback);
                                              int newcashback = int.parse(document['cashback']);
                                              int sumcash= newcashback+cash;
                                              usersCollection.doc(uid) // <-- Doc ID where data should be updated.
                                                  .update(
                                                  {
                                                    'cashback':sumcash.toString(),
                                                  });


                                               }
                                              print("the categoer"+document['category']);
                                          getCategoryCashback(document['category'], document['uid']);
                                          if (cashback !="0") {
                                            final CollectionReference usersCollection = FirebaseFirestore.instance.collection(uid);
                                            int cash = int.parse(cashback);
                                            int newcashback =
                                                int.parse(document['cashback']);
                                            int sumcash = newcashback + cash;
                                            usersCollection
                                                .doc(
                                                    uid) // <-- Doc ID where data should be updated.
                                                .update({
                                              'cashback': sumcash.toString(),
                                            });
                                          }
                                       
                                        // getCategoryCashback(document['category'], document['uid']);




                                          }
                                          else if (val== false) {
                                            ref.doc(document['name']) // <-- Doc ID where data should be updated.
                                                .update(
                                                {
                                                  'isSelected':false,
                                                });
                                            FirebaseFirestore.instance.collection(uid).doc("orders").collection("orders").doc(document['name']).delete();
                                            FirebaseFirestore.instance.collection(uid).doc("orders").collection(document["uid"]).doc(document['name']).delete();
                                            deleteSum(document['discount']);
                                            getUserscashback();

                                            int cash= int.parse(usercashback);
                                            int newcashback = int.parse(document['cashback']);
                                            int sumcash= cash-newcashback;
                                            final CollectionReference usersCollection = FirebaseFirestore.instance.collection(uid);

                                            usersCollection.doc(uid) // <-- Doc ID where data should be updated.
                                                .update(
                                                {
                                                  'cashback':sumcash.toString(),
                                                });


                                          }
                                        });



                                      },
                                      icon: document['isSelected']
                                          ? Icon(
                                        Icons.circle,
                                        color: Colors.red[700],
                                      )
                                          : Icon(
                                        Icons.circle_outlined,
                                        color: Colors.grey,
                                      ),
                                    ), 

                                    Container(
                                 // padding:  EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                                    child: Image.network(document['imageUrl'],
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,),


                                ),
                                    Container(
                                      //color: Colors.cyan,
                                      height:70,

                                      child: Column(
                                        //mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 2,),
                                          Container(

                                            child:
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 20.0),
                                                  child: Container(width:180,child: Text(document['name'],
                                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),)
                                                  ),
                                                ),


                                          ),
                                          SizedBox(height: 15,),

                                          Container(
                                            width: 180,
                                            child: Row(
                                              children: [
                                               // SizedBox(width: 5,),

                                                Container(child: Text("EGP"+document['discount'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),)),
                                                SizedBox(width: 15,),

                                                Text(document['Colors'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                                                SizedBox(width: 15,),
                                                Text(document['size'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                                              SizedBox(width: 15,),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 25,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.grey[400],
                                          size: 25,
                                        ),
                                        onPressed: () {
                                          ref.doc(document['name']).delete();


                                        },
                                      ),
                                    )


                                  ],
                                ),
                              ),

                            );

                          }).toList(),

                        ),
                      ),

                      Container(
                        child: Row(
                          children: [
                            SizedBox(width: 25,),
                            InkWell(
                              onTap: getCouponInfo,
                              child: Container(
                                width: 60,
                                height: 35,
                                decoration: BoxDecoration(
                                  //color: Colors.white,
                                  color:Colors.green[500],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green),

                                ),
                                child: Center(child: Text('تطبيق',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                              ),
                            ),
                            Padding(

                              padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                              child: Container(
                                height: 35,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                  //border: Border.all(color: Colors.black12),

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:11),
                                      child: TextField(
                                        textAlign: TextAlign.right,

                                        controller: _coupon,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'أدخل كوبون الخصم ',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),

                      SizedBox(height: 10,),

                      Container(
                        width: 310,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          //border: Border.all(color: Colors.black12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("الاجمالي : ",style: TextStyle(color: Colors.blue[900]),),
                                  SizedBox(width: 150,),
                                  Text(s.toString()+" جنية  ",style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold,fontSize: 14),),

                                ],
                              ),
                              Row(
                                children: [
                                  Text("الخصم : ",style: TextStyle(color: Colors.blue[900]),),
                                  SizedBox(width: 155,),
                                  Text(valueofCoupon+" جنية  ",style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold,fontSize: 14),),

                                ],
                              ),
                              Row(
                                children: [
                                  Text("المجموع : ",style: TextStyle(color: Colors.red[900]),),
                                  SizedBox(width: 150,),
                                  Text(total.toString()+" جنية  ",style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold,fontSize: 14),),

                                ],
                              )

                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),

                      Container(
                        child: Row(

                        children: [
                          IconButton(
                            onPressed: () {

                              setState(() {
                                iscash= !iscash;

                              });



                            },
                            icon: iscash
                                ? Icon(
                              Icons.circle,
                              color: Colors.blue[900],
                            )
                                : Icon(
                              Icons.circle_outlined,
                              color: Colors.black,
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              getUserscashback();
                              print(usercashback);
                              // getUserscashback();
                              final CollectionReference usersCollection = FirebaseFirestore.instance.collection(uid);
                              int cash= int.parse(usercashback);
                              setState(() {
                                //total=s-int.parse(couponvalues);
                                total=total-cash;
                              });
                              //total=total-cash;
                              usersCollection.doc(uid) // <-- Doc ID where data should be updated.
                                  .update(
                                  {
                                    'cashback':"0",
                                  });


                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: Text("استخدام المحفظة المالية للدفع",style: TextStyle(fontWeight: FontWeight.bold,color: iscash?Colors.blue[900]:Colors.black),),
                            ),
                          ),
                        ],
                      ),),

                      Container(
                        width: 300,
                          decoration: BoxDecoration(
                            //color: Colors.white,

                            borderRadius: BorderRadius.circular(12),

                          ),

                          padding: EdgeInsets.only(left: 0,),
                          child:
                          RaisedButton(
                            onPressed: () async {
                              setState(() {
                               // total=s-int.parse(couponvalues);
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderInfo(Sum: s.toString(), CouponValue: valueofCoupon, Total: total.toString(), VendorList: venderid,)));
                          },
                            child: Text("تابع عملية الشراء",style: TextStyle(color: Colors.white),),
                            color: Colors.red[900],
                          )
                      )

                    ]),
              ),);
          }),

    );

  }

}



