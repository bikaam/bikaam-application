
import 'dart:ui';

import 'package:bikaam/screens/show/Cart.dart';
import 'package:bikaam/screens/show/showList.dart';
import 'package:bikaam/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants.dart';
import '../loginscreen.dart';

String cart = '0';

class ProductItemScreenNoUser extends StatefulWidget {
  late String name, price, discount, after, image, venderid, about, category,cashback,shopname;
  late List Colorss = [];
  late List Sizes = [];

  ProductItemScreenNoUser(
      {required this.name,
        required this.price,
        required this.discount,
        required this.after,
        required this.image,
        required this.venderid,
        required this.about,
        required this.category,
        required this.Colorss,
        required this.Sizes,
        required this.cashback,
        required this.shopname});


  @override
  State<ProductItemScreenNoUser> createState() => _ProductItemScreenNoUserState(
      name, price, discount, after, image, venderid, about, category, Colorss,Sizes,cashback,shopname);
}

class _ProductItemScreenNoUserState extends State<ProductItemScreenNoUser> {
  String name, price, discount, after, image, venderid, about, category,cashback,shopname;
  late List Colorss = [];
  late List Sizes = [];
  _ProductItemScreenNoUserState(this.name, this.price, this.discount, this.after,
      this.image, this.venderid, this.about, this.category, this.Colorss,this.Sizes,this.cashback,this.shopname);
  check() {
    if(discount!=""){
      return  Row(
        children: [

          Text(
            discount.toString()+" EGP",
            style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 10),
          ),

          const SizedBox(width: defaultPadding ),
          Text("بدلا من "),
          const SizedBox(width: defaultPadding /4),
          Text(
              price +" EGP",
              style: TextStyle(color: Colors.black,fontSize: 10)
          ),
        ],
      );
    }
    else{
      return Row(
        children: [

          Text(
            price+"EGP",
            style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 10),
          ),

          const SizedBox(width: defaultPadding/2 ),

          Text(
              cashback +" EGP ",
              style: TextStyle(color: Colors.black,fontSize: 10)
          ),
          Text("cashback " ,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 10),),
          const SizedBox(width: defaultPadding/4 ),

        ],
      );
    }
  }
  late String coller;
  get(value){
    coller=value;
    print(coller);

  }
  late String sizze;
  getSize(value){
    sizze=value;
    print(sizze);

  }
  int sum=0;
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
  bool click=true;
  late FirebaseAuth _auth;
  late User? _user;

  bool iscolor=false;
  bool issize =false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                //height: 500,
                width: double.infinity,
                child: Image.network(
                  image,
                  height: 300,
                  //width:350,
                  fit: BoxFit.fill,
                ),
                //Image.asset("assets/images/new2.jpg",height: 300,fit: BoxFit.fill,),
              ),
              //buttonArrow(context),
              scroll(),

            ],
          ),

        ));
  }



  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          //Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  scroll() {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            //color: Colors.grey,

            padding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Color(0xFFECF2FF),
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 17),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Container(
                        child: IconButton(onPressed: () {
                          setState((){
                            click=!click;
                          });
                          FirebaseAuth auth= FirebaseAuth.instance;
                          String uid=auth.currentUser!.uid.toString();
                          Map <String,dynamic> data={"name": name,"venderid":venderid,'image':image,
                            'price':price,'after':after,"cashback":cashback,"discount":discount,"shopname":shopname,
                            "about":about,"category":category,"colors":Colorss,"sizes":Sizes,
                          };
                          FirebaseFirestore.instance.collection(uid).doc("orders").collection("likes").doc(name).set(data);
                          // FirebaseFirestore.instance.collection(venderid).doc("followers").collection("followers").doc(name).set(data);

                        },
                          icon: Icon(
                            click? Icons.favorite_border : Icons.favorite,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Share.share('com.bikaam.bikaam');

                        },
                        icon: Icon(
                          Icons.share_outlined,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  check(),
                  //////////////////Colors/////////////////////////////////////

                  Text(
                    "الالوان",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.teal),
                  ),

                  Container(
                    //color: Colors.grey,
                      child: getItems(Colorss)
                  ),
                  //print(collor);

                  /////////////////Sizes///////////////////////////////////////////
                  SizedBox(
                    height: 5,
                  ),

                  Text(
                    "المقاسات",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.teal),
                  ),

                  Container(
                    //color: Colors.grey,
                      child: getSizes(Sizes)),
                  ///////////about////////////////////////////
                  SizedBox(height: 10,),
                  Text(
                    "عن المنتج",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 50,
                    width: double.infinity,
                    // color: Colors.,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12)
                    ),
                    child: Row(
                      children: [

                        GestureDetector(
                          onTap: (){},
                          child: Container(

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(about,style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ///////////////////Return Policy/////////////////////////////////////////////
                  SizedBox(height: 10,),
                  Container(
                    height: 50,
                    width: double.infinity,
                    // color: Colors.,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.policy_outlined,color: Colors.cyan[200],size: 20,),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){
                            var altertDialog = AlertDialog(
                              title: Row(children: [
                                Text("سياسة البيع و الاسترجاع",style: TextStyle(color: Colors.cyan[900] ,fontSize: 15),),
                              ],),
                              content:
                              Container(
                                  height: 250,
                                  child: Text("")),

                            );
                            showDialog(context: context, builder: (BuildContext context)
                            {
                              return altertDialog;
                            });
                          },
                          child: Container(

                            child: Text("سياسة البيع و الاسترجاع",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /////////////AddToCart///////////////////////////
                  SizedBox(height: 10,),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        _auth = FirebaseAuth.instance;
                        _user = _auth.currentUser;
                        if(_user==null){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                        }else{
                          if(coller==null || sizze==null){
                            var altertDialog = AlertDialog(
                              backgroundColor: Color(0xFFECF2FF),
                              elevation: 20,
                              title: Row(children: [
                                Text("اختر اللون و الحجم ",style: TextStyle(color: Colors.black ,fontSize: 20,fontWeight: FontWeight.bold),),
                                //Text(document['code'],style: TextStyle(color: Colors.black,fontSize: 20),),
                              ],),

                              content:
                              Container(
                                  height:200,

                                  color: Color(0xFFECF2FF),
                                  child: Column(
                                    children: [
                                      //SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Container(
                                          // width: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            //  padding: const EdgeInsets.symmetric(horizontal: 20),
                                              children :[
                                                Text(
                                                  "colors",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.teal),
                                                ),

                                                Container(
                                                  //color: Colors.grey,
                                                    child: getItems(Colorss)
                                                ),
                                                //print(collor);

                                                /////////////////Sizes///////////////////////////////////////////
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Text(
                                                  "Size",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.teal),
                                                ),

                                                Container(
                                                  //color: Colors.grey,
                                                    child: getSizes(Sizes)),
                                              ]

                                          ),
                                        ),
                                      ),
                                      SizedBox(height:20,),

                                      GestureDetector(
                                        onTap: () async {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 170,

                                          decoration: BoxDecoration(
                                            color: Colors.blue[700],
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child:
                                          Center(child: Text("حفظ",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                                        ),

                                      ),
                                    ],
                                  )
                              ),


                            );
                            showDialog(context: context, builder: (BuildContext context)
                            {
                              return altertDialog;
                            });

                          }else{
                            Map <String,dynamic> data={"name":name,"price":price,"discount":discount,
                              "imageUrl":image,"category":category,"about":about,"after":after,
                              "uid":venderid,"Colors":coller,"size":sizze,'cashback':cashback,"isSelected":false
                            };
                            FirebaseAuth auth= FirebaseAuth.instance;
                            String uid=auth.currentUser!.uid.toString();
                            FirebaseFirestore.instance.collection(uid).doc("Cart").collection("Cart").doc(name).set(data);
                            getUsersData(uid);

                            Map <String,dynamic> check={"check":after,};
                            // FirebaseFirestore.instance.collection(uid).doc("check").collection("check").add(check);

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                          }
                        }


                      },
                      child: Container(
                        height: 40,
                        width: 200,
                        color: Colors.black,

                        child: Center(
                          child: Text("اضافة الي السلة",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  Text(
                    "منتجات مشابهة",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  SizedBox(height: 5,),
                  ShowListProduct(value:category,venderid:venderid),

                ],
              ),
            ),
          );
        });
  }


  Widget getItems(List Colorss) {
    return StreamBuilder(
      //1597917013710
        stream: Stream.periodic(Duration(seconds: 2)),
        builder: (context, snapshot) {
          // String urlremoved = "I, am, jits555";

          //List<String> spec_list = Colorss.(", ");
          int speclistlen = Colorss.length;

          return Container(
              height: 40,
              width: double.infinity,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: speclistlen,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        String collor=Colorss[index];
                        print(Colorss[index]);
                        get(Colorss[index]);
                        //return Colorss[index];
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          child: Text(
                            Colorss[index],
                          )),
                    ),
                  );
                },
              ));
        });
  }

  Widget getSizes(List Sizes) {
    return StreamBuilder(
      //1597917013710
        stream: Stream.periodic(Duration(seconds: 2)),
        builder: (context, snapshot) {
          // String urlremoved = "I, am, jits555";

          //List<String> spec_list = Colorss.(", ");
          int speclistlen = Sizes.length;

          return Container(
              height: 40,
              width: double.infinity,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: speclistlen,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        String size=Sizes[index];
                        print(Sizes[index]);
                        getSize(Sizes[index]);
                        //return Colorss[index];
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          child: Text(
                            Sizes[index],
                          )),
                    ),
                  );
                },
              ));
        });
  }
}
/*   Column(
                  children: [
                    SizedBox(height: 10,),

                    Expanded(
                      child:
                      ListView(

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

                                          // selectedContacts.add(ContactModel(name, phoneNumber, true));
                                        } else if (val== false) {
                                          ref.doc(document['name']) // <-- Doc ID where data should be updated.
                                              .update(
                                              {
                                                'isSelected':false,
                                              });
                                          FirebaseFirestore.instance.collection(uid).doc("orders").collection("orders").doc(document['name']).delete();
                                          FirebaseFirestore.instance.collection(uid).doc("orders").collection(document["uid"]).doc(document['name']).delete();
                                          deleteSum(document['discount']);

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
                                            child: Container(width:200,child: Text(document['name'],
                                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),)
                                            ),
                                          ),


                                        ),
                                        SizedBox(height: 15,),

                                        Container(
                                          width: 200,
                                          child: Row(
                                            children: [
                                              // SizedBox(width: 5,),

                                              Container(child: Text("EGP"+document['discount'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),)),
                                              SizedBox(width: 20,),

                                              Text(document['Colors'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                                              SizedBox(width: 20,),
                                              Text(document['size'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
                                              SizedBox(width: 20,),
                                            ],
                                          ),
                                        ),

                                        /*   Container(
                                            child: Row(
                                              children: [
                                                SizedBox(width: 10,),
                                                InkWell(
                                                  onTap: (){
                                                    setState((){
                                                      index=index+1;

                                                    });
                                                  },
                                                  child: Container(
                                                    child: Icon(Icons.add),
                                                    decoration: BoxDecoration(

                                                        border: Border.all(color: Colors.black12)
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 20,),

                                                Text(index.toString(),style: TextStyle(color: Colors.blue),),
                                                SizedBox(width: 20,),

                                                InkWell(
                                                  onTap:(){
                                                    setState((){
                                                      index=index-1;

                                                    });
                                                  },
                                                  child: Container(

                                                    child: Center(child: Container(

                                                      decoration: BoxDecoration(

                                                          border: Border.all(color: Colors.black)
                                                      ),
                                                      height: 2,
                                                      width: 15,
                                                    )),
                                                    decoration: BoxDecoration(

                                                        border: Border.all(color: Colors.black12)
                                                    ),
                                                    height: 25,
                                                    width: 25,
                                                  ),
                                                ),
                                                SizedBox(width: 50,),
                                                Container(
                                                  // height: 100,

                                                  child:  IconButton(
                                                    icon: Icon(Icons.delete,size: 18,color: Colors.grey,),
                                                    onPressed: (){
                                                      getUsersData();
                                                      getordernum();
                                                      FirebaseFirestore.instance.collection(uid).doc("Cart").collection('Cart').doc(document['name']).delete();
                                                      // getUsersData();

                                                    },

                                                  ),
                                                ),

                                              ],


                                            ),
                                          ),*/

                                        //Calculate(document['after']),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          );

                        }).toList(),

                      ),
                    ),


                  ]),
            ),);
        });

        //stream: Stream.periodic(Duration(seconds: 2)),
        builder: (context, snapshot) {

          int speclistlen = Colorss.length;

          return Container(
            height: 40,
            width: double.infinity,
            color: Colors.white,
            child:
          /*  ListView.separated(

              itemBuilder: (BuildContext context,int index)=>ListTile(
                //scrollDirection: Axis.horizontal,

                leading:Container(

                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        color: iscolor?Colors.red:Colors.white,

                      ),
                      child: Text(
                        Colorss[index],
                      )
                  ),
                    selectedTileColor:Colors.red,
                selectedColor: Colors.red,

                //selected: Colorss[i],

                ),

                separatorBuilder: (BuildContext context,int index)=>Divider(
                  height: 1,
                ),
                itemCount: speclistlen,
             // selectedTileColor

            ),*/
            ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: speclistlen,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){

                      },
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            iscolor=!iscolor;
                          });
                          print(iscolor.toString());
                          //iscolor!=iscolor;
                          String collor=Colorss[index];
                          print(Colorss[index]);
                          get(Colorss[index]);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                              color: iscolor?Colors.red:Colors.white,

                            ),
                            child: Text(
                              Colorss[index],
                            )),
                      ),
                    ),
                  );
                },
              )
          );*/