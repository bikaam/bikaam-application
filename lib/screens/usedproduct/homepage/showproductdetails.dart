import 'dart:ui';

import 'package:bikaam/screens/show/Cart.dart';
import 'package:bikaam/screens/show/showList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../admin/pages/adminListProdutcs.dart';

class ShowUsedDetails extends StatefulWidget {
  late String name, price,  image, venderid, about, category,vendorname,phone,address;
  late List Colorss = [];
  late List Sizes = [];

   ShowUsedDetails(
       {required this.name,
         required this.price,
         required this.image,
         required this.venderid,
         required this.about,
         required this.category,
         required this.Colorss,
         required this.Sizes,
         required this.vendorname,
         required this.phone,
         required this.address}
       );

  @override
  State<ShowUsedDetails> createState() => _ShowUsedDetailsState(
      name, price, image, venderid, about, category, Colorss,Sizes,vendorname,phone,address);

}

class _ShowUsedDetailsState extends State<ShowUsedDetails> {
  String name, price, image, venderid, about, category,vendername,phone,address;
  late List Colorss = [];
  late List Sizes = [];
  _ShowUsedDetailsState(this.name, this.price,
      this.image, this.venderid, this.about, this.category, this.Colorss,this.Sizes,this.vendername,this.phone,this.address);

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
  bool click=true;
  final _message=TextEditingController();


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
                        width: 70,
                      ),
                      Container(
                        child: IconButton(onPressed: () {
                          setState((){
                            click=!click;
                          });
                          FirebaseAuth auth= FirebaseAuth.instance;
                          String uid=auth.currentUser!.uid.toString();
                          Map <String,dynamic> data={"name": name,"venderid":venderid,'image':image,
                            'price':price,'vendername':vendername,'phone':phone
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
                        onPressed: () {},
                        icon: Icon(
                          Icons.share_outlined,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                //  check(),
                  //////////////price////////////////////////////////
                  Row(
                    children: [
                      Text(
                        price+" EGP",
                        style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 15),
                      ),
                    ],
                  ),
                  //////////////about vendor///////////////////////////////////////////////////////
                  SizedBox(height: 10,),
                  Text(
                    "About Vendor",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.teal),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 35,
                    width: double.infinity,
                    // color: Colors.,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.symmetric(vertical:BorderSide.none)
                    ),
                    child: Row(
                      children: [

                        GestureDetector(
                          onTap: (){},
                          child: Container(

                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(vendername,style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey[800]),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    width: double.infinity,
                    // color: Colors.,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.symmetric(vertical:BorderSide.none)
                       // border: Border.all(color: Colors.black12)
                    ),
                    child: Row(
                      children: [

                        GestureDetector(
                          onTap: (){},
                          child: Container(

                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(address,style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey[800]),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //////////////////Colors/////////////////////////////////////
                  SizedBox(height: 5,),
                  Text(
                    "colors",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.teal),
                  ),

                  Container(
                    //color: Colors.grey,
                      child: getItems(Colorss)),
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
                  ///////////about////////////////////////////
                  SizedBox(height: 10,),
                  Text(
                    "About Product",
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
                  /////////////AddToCart///////////////////////////
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      ///////add price//////////////////
                      Container(
                        child: GestureDetector(
                          onTap: (){
                            var altertDialog = AlertDialog(
                              backgroundColor: Color(0xFFECF2FF),
                              elevation: 20,


                              title: Row(children: [
                                Text("اضف عرضك",style: TextStyle(color: Colors.black ,fontSize: 20,fontWeight: FontWeight.bold),),
                                //Text(document['code'],style: TextStyle(color: Colors.black,fontSize: 20),),

                              ],),

                              content:
                              Container(
                                  height:150,

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
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: TextField(


                                              controller: _message,
                                              //obscureText: true,

                                              decoration: InputDecoration(
                                                helperMaxLines: 5,
                                                contentPadding: EdgeInsets.only(top: 20,bottom: 20),
                                                border: InputBorder.none,
                                                hintText: price.toString(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height:20,),

                                      GestureDetector(
                                        onTap: () async {

                                          FirebaseAuth auth= FirebaseAuth.instance;
                                          String uid=auth.currentUser!.uid.toString();
                                          Map <String,dynamic> data={"message":_message.text,"senderid":uid,"sendername":vendername,"senderimage":"data:image/png;base64,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"};
                                          FirebaseFirestore.instance.collection(venderid).doc("orders").collection("message").add(data);
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
                                          Center(child: Text("ارسال",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
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
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            color: Colors.black,

                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                                  child: Icon(
                                    Icons.add_box,
                                    color: Colors.grey[400],
                                    size: 20,
                                  ),
                                ),
                                Center(
                                  child: Text("add offer",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      ////////call us ////////////////
                      Container(
                        child: GestureDetector(
                          onTap: (){
                            launch("tel://+2"+phone.toString());
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            //color: Colors.black,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                            ),

                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.grey[900],
                                    size: 20,
                                  ),
                                ),
                                Center(
                                  child: Text("Call",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      ///////send message///////////////////////
                      Container(
                        child: GestureDetector(
                          onTap: (){
                            launch("whatsapp://send?phone=+2"+phone);
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            color: Colors.black,

                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 7),
                                  child: Icon(
                                    Icons.whatsapp,
                                    color: Colors.grey[400],
                                    size: 20,
                                  ),
                                ),
                                Center(
                                  child: Text("whatsapp",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5,),
                  Text(
                    "products",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  SizedBox(height: 5,),
                  AdminShowListProduct(),
                 // ShowListProduct(value:category,venderid:venderid),

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

