import 'dart:ui';

import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/loginscreen.dart';
import 'package:bikaam/screens/showproduct/showallproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../SignScreen.dart';
import '../../constants.dart';
import '../profile/profile_screen.dart';
import '../show/ListCategory.dart';
import '../show/ListProducts.dart';
import '../show/Video.dart';
import '../show/ordershow.dart';
import '../usedproduct/homepage/homwpage.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:share_plus/share_plus.dart';

import 'homescreen2.dart';

String firstName = 'loading...';
String lastName = 'loading...';
String title = 'loading...';


class ProfilePage1 extends StatefulWidget {
  late String value;

  ProfilePage1({required this.value});
  @override
  State<ProfilePage1> createState() => _ProfilePage1State(value,);
}

class _ProfilePage1State extends State<ProfilePage1> {
  String value;
  _ProfilePage1State(this.value);
  late String userid;
  set index(int index) {}


  @override


  final _message=TextEditingController();

//Creating a reference to the collection 'users'

  //This function will set the values to firstName, lastName and title from the data fetched from firestore
  void getUsersData() {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection(uid);
    usersCollection.doc(uid).get().then((value) {
      var fields = (value.data() as Map<String,dynamic>);
      setState(() {
        firstName = fields["name"] ;
        print(firstName);
      });
    });
  }
  late FirebaseAuth _auth;
  late User? _user;
  Widget build(BuildContext context) {
    int index = 2;
    bool click = true;
    final CollectionReference ref = FirebaseFirestore.instance.collection(value) ;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Builder(
        builder: (context) {
          return StreamBuilder(
              stream: ref.snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    'no values',
                    style: TextStyle(color: Colors.black),
                  );
                }
                return ListView(
                  //padding: EdgeInsets.all(30),
                  //  shrinkWrap: true,
                //  physics: NeverScrollableScrollPhysics(),

                   children: snapshot.data!.docs.map((document) {

                    return Container(

                      child: Column(
                        children: [
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          Stack(
                            clipBehavior: Clip.none,
                            //fit: StackFit.expand,
                            children: [
                              Container(
                               // margin: const EdgeInsets.only(bottom: 50),
                                height: 200,
                                //color: Color(0xFFECF2FF),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(60),
                                      bottomLeft: Radius.circular(30)),
                                  color: Colors.black,
                                ),
                                child: Image.network(
                                  document['coverUrl'],
                                  //height: 150,
                                  width:350,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Positioned(
                                top: 90,
                                left: 110,
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.grey[100],
                                  backgroundImage:NetworkImage(
                                    document['imageUrl'],

                                  ) ,
                                ),
                              ),
                            ],
                          ),
                          //////////////////////name////////////////////////////////////////////////////////////////////
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            document['shopname'],
                            style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20,color: Colors.black),
                          ),
                          //////////////////address///////////////////////////////////////////////////////////////////////
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 18,
                              ),
                              // color: Colors.cyan,
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/icons/Location.svg"),
                                  const SizedBox(width: defaultPadding / 2),
                                  Text(document['address'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          ///////////////////phone////////////////////////////////////////////////////////////////////////////
                          SizedBox(
                            height: 7,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(

                              // color: Colors.cyan,
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.grey[400],
                                      size: 15,
                                    ),
                                  ),
                                  const SizedBox(width: defaultPadding / 2),
                                  Text(document['phone'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          /////////////////////ABOUT////////////////////////////////////////////////////////////////////
                          SizedBox(
                            height: 7,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(

                              // color: Colors.cyan,
                              child: Row(
                                children: [
                                  const SizedBox(width: defaultPadding / 2),
                                  Text(document['about'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          /////////////////Rating///////////////////////////////////////////////////////////
                          SizedBox(
                            height: 7,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              child: Row(
                                children: [
                                  RatingBar(
                                    minRating: 1,
                                    maxRating: 5,
                                    initialRating: 3,
                                    allowHalfRating: true,
                                    itemSize: 20,
                                    // onRatingUpdate: _saveRating,
                                    ratingWidget: RatingWidget(
                                        full: Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        half: Image.asset('assets/heart_half.png'),
                                        empty: Icon(
                                          Icons.star,
                                          color: Colors.grey,
                                        )),
                                    onRatingUpdate: (double value) {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //////////////////Social media ////////////////////////////////////////////////////////////
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 18,
                            ),
                            // color: Colors.cyan,
                            child: Row(
                              children: [

                                IconButton(
                                  onPressed: () {
                                    launch(document["facebook"]);
                                  },
                                  icon: Icon(
                                    Icons.facebook_rounded,
                                    color: Colors.blue[400],
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 90,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Share.share('com.bikaam.bikaam');
                                  },
                                  icon: Icon(
                                    Icons.share_outlined,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ////////////////////////Follow///////////////////////////////////////////////////////////////////////
                          const SizedBox(height: 16),
                          //FollowButton(value: document["uid"],),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget> [

                            //  BuildProfileButton(name: document['shopname'], image: document['imageUrl'], venderid:document['uid']),

                                InkWell(
                                  onTap: () async {
                                    _auth = FirebaseAuth.instance;
                                    _user = _auth.currentUser;
                                    if (_user==null) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));

                                    }else{
                                      getUsersData();
                                      FirebaseAuth auth= FirebaseAuth.instance;
                                      String uid=auth.currentUser!.uid.toString();
                                      Map <String,dynamic> data={"name":document["shopname"],"imageUrl":document['imageUrl'],"uid":uid,
                                        "coverUrl":document["coverUrl"],"venderid":document["uid"],"address":document['address'],"phone":document['phone'],
                                      };
                                      Map <String,dynamic> userdata={"name":firstName,"uid":uid,"isSelected":false
                                      };
                                      final coll= FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(value);
                                      if( ((await coll.get())!.exists)){
                                        var altertDialog = AlertDialog(
                                          title: Row(children: [
                                            Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                                          ],),
                                          content:
                                          Text("انت بالفعل من متابعينا"),

                                        );
                                        showDialog(context: context, builder: (BuildContext context)
                                        {
                                          return altertDialog;
                                        });
                                        //////////

                                      }else{
                                        FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(document['uid']).set(data);
                                        FirebaseFirestore.instance.collection(document['uid']).doc("followers").collection("followers").doc(uid).set(userdata);
                                        var altertDialog = AlertDialog(
                                          title: Row(children: [
                                            Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                                          ],),
                                          content:
                                          Text("تم المتابعة بنجاح "),

                                        );
                                        showDialog(context: context, builder: (BuildContext context)
                                        {
                                          return altertDialog;
                                        });
                                      }
                                    }

                                  },
                                  child: Container(


                                      child: Row(
                                      children: [
                                        SizedBox(width: 5,),
                                        Icon(Icons.person_add_alt_1,color: Colors.white,),
                                        SizedBox(width: 7,),
                                        Text("متابعة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                      ],
                                  ),


                                    color:Colors.blue ,
                                    height: 45,
                                    width:100,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                InkWell(
                                  onTap: (){
                                    _auth = FirebaseAuth.instance;
                                    _user = _auth.currentUser;
                                    if(_user==null){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                                    }
                                    else{
                                      var altertDialog = AlertDialog(
                                        backgroundColor: Color(0xFFECF2FF),
                                        elevation: 20,
                                        title: Row(children: [
                                          Text("ارسال رسالة",style: TextStyle(color: Colors.black ,fontSize: 20,fontWeight: FontWeight.bold),),
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
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                      child: Container(
                                                        height: 100,
                                                        child: TextField(


                                                          controller: _message,
                                                          maxLines: null,
                                                          keyboardType: TextInputType.multiline,
                                                          //obscureText: true,

                                                          decoration: InputDecoration(
                                                            helperMaxLines: 8,
                                                            contentPadding: EdgeInsets.only(top: 10,bottom: 20),
                                                            border: InputBorder.none,
                                                            hintText: 'اكتب رسالتك',
                                                          ),
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
                                                    Map <String,dynamic> data={"message":_message.text,"uid":uid,"username":firstName};
                                                    FirebaseFirestore.instance.collection(document['uid']).doc("messages").collection("messages").add(data);
                                                    // FirebaseFirestore.instance.collection(uid).doc("orders").collection("orders").add(data);
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

                                    }

                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.email,color: Colors.white,),
                                          SizedBox(width: 5,),
                                          Text("ارسال رسالة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                    color: Colors.red,
                                    height: 45,
                                    width: 120,
                                  ),
                                ),
                                const SizedBox(width: 25),
                                InkWell(
                                  onTap:(){
                     launch("whatsapp://send?phone=+2"+document['phone']);

                  } ,

                                  //   child: IconButton(
                                //   onPressed: () {
                                //     launch("whatsapp://send?phone=+2"+document['phone']);
                                //   },
                                //   icon: Icon(
                                //     Icons.whatsapp,
                                //     color: Colors.green[400],
                                //     size: 40,
                                //   ),
                                // ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey[100],
                                    child:Icon(
                                      Icons.whatsapp_outlined,
                                      color: Colors.green[600],
                                      size: 42,
                                    ) ,

                                  ),
                                )

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ///////////////////Banner//////////////////////////////////////////////////////////////////////////
                          document['banner']==null? Image.network(
                            document['banner'],
                            width: 300,
                            fit: BoxFit.fill,
                          ):Container(),

                          /////////////////////////////////////////////////////////////////////////////////////////////////////
                          SizedBox(
                            height: 10,
                          ),
                          ///////////////////list category//////////////////////////////////////////////////////////////////////
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // width: 400,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                     //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage2(cat:document['category'],value: value, )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:0),
                                      child: Container(
                                        width: 50,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.blue,
                                          border: Border.all(color: Colors.black12),
                                        ),
                                        child: Center(child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Text("الكل",style: TextStyle(color: Colors.white),),
                                        )),
                                      ),
                                    ),
                                  ),
                                  ListCategory(value: document['uid'],),
                                ],
                              ),
                            ),
                          ),
                         // ListCategory(value:document['uid']),
                          ////////////////////List Products/////////////////////////////////////////////////////////////////////
                          ListProducts(value:document['uid']),
                          SizedBox(height: 50,),
                          /////////////////////////////////////////////////////////////////////////////////////////////////////

                        ],
                      ),
                    );
                  }).toList(),
                );
              });
        }
      ),
      bottomNavigationBar: CurvedNavigationBar(
        //backgroundColor: Colors.blueAccent,
          color: Colors.blue,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.redAccent,
          animationCurve: Curves.easeInOut,
          height: 60,
          index: index,
          animationDuration: Duration(milliseconds: 10),
          items: [
            CurvedNavigationBarItem(
              child: Icon(Icons.perm_identity,color: Colors.white,),
              label: 'ملف شخصي',
              labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.article_outlined,color: Colors.white,),
              label: 'الطلبات',
              labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.home,color: Colors.white,),
              label: 'الرئيسية',
              labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.storefront,color: Colors.white,),
              label: 'المستعمل',
              labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.video_collection,color: Colors.white,),
              label: 'فيدوهات',
              labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
            ),
          ],
          onTap: onItemPressed),

    );

     /* return Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                //height: 500,
                child: Column(
                  children: [
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    Stack(
                      clipBehavior: Clip.none,
                      //fit: StackFit.expand,
                      children: [
                        Container(
                          // margin: const EdgeInsets.only(bottom: 50),
                          height: 200,
                          //color: Color(0xFFECF2FF),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(60),
                                bottomLeft: Radius.circular(30)),
                            color: Colors.black,
                          ),
                          child: Image.network(
                            //'${snapshot.data!.docs[index]['coverUrl']}',
                            cover,

                            //document['coverUrl'],
                            //height: 150,
                            width:350,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          top: 90,
                          left: 110,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.grey[100],
                            backgroundImage:NetworkImage(
                              logo,
                              //'${snapshot.data!.docs[index]['imageUrl']}',
                              //document['imageUrl'],

                            ) ,
                          ),
                        ),
                      ],
                    ),
                    //////////////////////name////////////////////////////////////////////////////////////////////
                    SizedBox(
                      height: 35,
                    ),
                    Text(name,
                      // '${snapshot.data!.docs[index]['shopname']}',

                      //document['shopname'],
                      style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20,color: Colors.black),
                    ),
                    //////////////////address///////////////////////////////////////////////////////////////////////
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 18,
                        ),
                        // color: Colors.cyan,
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/Location.svg"),
                            const SizedBox(width: defaultPadding / 2),
                            Text(
                                address,
                                //'${snapshot.data!.docs[index]['address']}',

                                //document['address'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                    ///////////////////phone////////////////////////////////////////////////////////////////////////////
                    SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(

                        // color: Colors.cyan,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(
                                Icons.phone,
                                color: Colors.grey[400],
                                size: 15,
                              ),
                            ),
                            const SizedBox(width: defaultPadding / 2),
                            Text(
                                whatsapp,
                                //'${snapshot.data!.docs[index]['phone']}',

                                // document['phone'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                    /////////////////////ABOUT////////////////////////////////////////////////////////////////////
                    SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(

                        // color: Colors.cyan,
                        child: Row(
                          children: [
                            const SizedBox(width: defaultPadding / 2),
                            Text("kldjfljljld",
                                //'${snapshot.data!.docs[index]['about']}',

                                // document['about'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                    /////////////////Rating///////////////////////////////////////////////////////////
                    SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        child: Row(
                          children: [
                            RatingBar(
                              minRating: 1,
                              maxRating: 5,
                              initialRating: 3,
                              allowHalfRating: true,
                              itemSize: 20,
                              // onRatingUpdate: _saveRating,
                              ratingWidget: RatingWidget(
                                  full: Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  half: Image.asset('assets/heart_half.png'),
                                  empty: Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                  )),
                              onRatingUpdate: (double value) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    //////////////////Social media ////////////////////////////////////////////////////////////
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 18,
                      ),
                      // color: Colors.cyan,
                      child: Row(
                        children: [

                          IconButton(
                            onPressed: () {
                              launch(facebook
                                //'${snapshot.data!.docs[index]['facebook']}',

                                //document["facebook"]
                              );
                            },
                            icon: Icon(
                              Icons.facebook_rounded,
                              color: Colors.blue[400],
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 90,
                          ),
                          IconButton(
                            onPressed: () {
                              Share.share('com.bikaam.bikaam');
                            },
                            icon: Icon(
                              Icons.share_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ////////////////////////Follow///////////////////////////////////////////////////////////////////////
                    //const SizedBox(height: 2),
                    //FollowButton(value: document["uid"],),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [

                          //  BuildProfileButton(name: document['shopname'], image: document['imageUrl'], venderid:document['uid']),

                          InkWell(
                            onTap: () async {
                              /*  _auth = FirebaseAuth.instance;
                                            _user = _auth.currentUser;
                                            if (_user==null) {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));

                                            }else{
                                              getUsersData();
                                              FirebaseAuth auth= FirebaseAuth.instance;
                                              String uid=auth.currentUser!.uid.toString();
                                              Map <String,dynamic> data={"name":document["shopname"],"imageUrl":document['imageUrl'],"uid":uid,
                                                "coverUrl":document["coverUrl"],"venderid":document["uid"],"address":document['address'],"phone":document['phone'],
                                              };
                                              Map <String,dynamic> userdata={"name":firstName,"uid":uid,"isSelected":false
                                              };
                                              final coll= FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(value);
                                              if( ((await coll.get())!.exists)){
                                                var altertDialog = AlertDialog(
                                                  title: Row(children: [
                                                    Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                                                  ],),
                                                  content:
                                                  Text("انت بالفعل من متابعينا"),

                                                );
                                                showDialog(context: context, builder: (BuildContext context)
                                                {
                                                  return altertDialog;
                                                });
                                                //////////

                                              }else{
                                                FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(document['uid']).set(data);
                                                FirebaseFirestore.instance.collection(document['uid']).doc("followers").collection("followers").doc(uid).set(userdata);
                                                var altertDialog = AlertDialog(
                                                  title: Row(children: [
                                                    Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                                                  ],),
                                                  content:
                                                  Text("شكرا لانضمامك لعائلتنا "),

                                                );
                                                showDialog(context: context, builder: (BuildContext context)
                                                {
                                                  return altertDialog;
                                                });
                                              }
                                            }
*/
                            },
                            child: Container(


                              child: Row(
                                children: [
                                  SizedBox(width: 5,),
                                  Icon(Icons.person_add_alt_1,color: Colors.white,),
                                  SizedBox(width: 7,),
                                  Text("متابعة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                ],
                              ),


                              color:Colors.blue ,
                              height: 45,
                              width:100,
                            ),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: (){
                              _auth = FirebaseAuth.instance;
                              _user = _auth.currentUser;
                              if(_user==null){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                              }
                              else{
                                var altertDialog = AlertDialog(
                                  backgroundColor: Color(0xFFECF2FF),
                                  elevation: 20,
                                  title: Row(children: [
                                    Text("ارسال رسالة",style: TextStyle(color: Colors.black ,fontSize: 20,fontWeight: FontWeight.bold),),
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
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Container(
                                                  height: 100,
                                                  child: TextField(


                                                    controller: _message,
                                                    maxLines: null,
                                                    keyboardType: TextInputType.multiline,
                                                    //obscureText: true,

                                                    decoration: InputDecoration(
                                                      helperMaxLines: 8,
                                                      contentPadding: EdgeInsets.only(top: 10,bottom: 20),
                                                      border: InputBorder.none,
                                                      hintText: 'اكتب رسالتك',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height:20,),

                                          GestureDetector(
                                            onTap: () async {
                                              /*
                                                            FirebaseAuth auth= FirebaseAuth.instance;
                                                            String uid=auth.currentUser!.uid.toString();
                                                            Map <String,dynamic> data={"message":_message.text,"uid":uid,"username":firstName};
                                                            FirebaseFirestore.instance.collection(document['uid']).doc("messages").collection("messages").add(data);
                                                            // FirebaseFirestore.instance.collection(uid).doc("orders").collection("orders").add(data);
                                                            Navigator.pop(context);*/

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

                              }

                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.email,color: Colors.white,),
                                    SizedBox(width: 5,),
                                    Text("ارسال رسالة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                              color: Colors.red,
                              height: 45,
                              width: 120,
                            ),
                          ),
                          const SizedBox(width: 25),
                          InkWell(
                            onTap:(){
                              launch(
                                //'${snapshot.data!.docs[index]['shopname']}',

                                  "whatsapp://send?phone=+2"+whatsapp
                                //'${snapshot.data!.docs[index]['phone']}'
                              );

                            } ,

                            //   child: IconButton(
                            //   onPressed: () {
                            //     launch("whatsapp://send?phone=+2"+document['phone']);
                            //   },
                            //   icon: Icon(
                            //     Icons.whatsapp,
                            //     color: Colors.green[400],
                            //     size: 40,
                            //   ),
                            // ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[100],
                              child:Icon(
                                Icons.whatsapp_outlined,
                                color: Colors.green[600],
                                size: 42,
                              ) ,

                            ),
                          )

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    ///////////////////Banner//////////////////////////////////////////////////////////////////////////
                    //'${snapshot.data!.docs[index]['shopname']}',

                    /*   '${snapshot.data!.docs[index]['shopname']}'==null? Image.network(
                            '${snapshot.data!.docs[index]['shopname']}',
                                    width: 300,
                                    fit: BoxFit.fill,
                                  ):Container(), */

                    /*  document['banner']==null? Image.network(
                                    document['banner'],
                                    width: 300,
                                    fit: BoxFit.fill,
                                  ):Container(),*/

                    /////////////////////////////////////////////////////////////////////////////////////////////////////

                    ///////////////////list category//////////////////////////////////////////////////////////////////////
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white,
                          //border: Border.all(color: Colors.black12),
                        ),
                        // width: 400,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (){
                                //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage2(cat:document['category'],value: value, )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  width: 50,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  child: Center(child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text("الكل",style: TextStyle(color: Colors.white),),
                                  )),
                                ),
                              ),
                            ),
                            ListCategory(value: value,),
                          ],
                        ),
                      ),
                    ),
                    // ListCategory(value:document['uid']),
                    //////////////////////////////////////////
                    /*   Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(

                                      // color: Colors.cyan,
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllProduct(value: value)));
                                        },
                                        child: Row(
                                          children: [
                                            const SizedBox(width: defaultPadding / 2),
                                            Text(" عرض الكل ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue[900])),
                                            Icon(Icons.arrow_back_ios_new_sharp,size: 17,color: Colors.blue[900],),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ), */
                    ////////////////////List Products/////////////////////////////////////////////////////////////////////
                    //   ListProducts(value:value),
                    SizedBox(height: 10,),
                    /////////////////////////////////////////////////////////////////////////////////////////////////////

                  ],
                ),
              ),
            ),
            ListProducts(value: value),
          ],
        )
      /*  CustomScrollView(

        slivers: [
    SliverList(delegate: SliverChildBuilderDelegate(
    ( context ,  index){
        return  Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            //height: 500,
            child: Column(
              children: [
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                Stack(
                  clipBehavior: Clip.none,
                  //fit: StackFit.expand,
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(bottom: 50),
                      height: 200,
                      //color: Color(0xFFECF2FF),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(60),
                            bottomLeft: Radius.circular(30)),
                        color: Colors.black,
                      ),
                      child: Image.network(
                        //'${snapshot.data!.docs[index]['coverUrl']}',
                        cover,

                        //document['coverUrl'],
                        //height: 150,
                        width:350,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                      top: 90,
                      left: 110,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey[100],
                        backgroundImage:NetworkImage(
                          logo,
                          //'${snapshot.data!.docs[index]['imageUrl']}',
                          //document['imageUrl'],

                        ) ,
                      ),
                    ),
                  ],
                ),
                //////////////////////name////////////////////////////////////////////////////////////////////
                SizedBox(
                  height: 35,
                ),
                Text(name,
                  // '${snapshot.data!.docs[index]['shopname']}',

                  //document['shopname'],
                  style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20,color: Colors.black),
                ),
                //////////////////address///////////////////////////////////////////////////////////////////////
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 18,
                    ),
                    // color: Colors.cyan,
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/Location.svg"),
                        const SizedBox(width: defaultPadding / 2),
                        Text(
                            address,
                            //'${snapshot.data!.docs[index]['address']}',

                            //document['address'],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                ///////////////////phone////////////////////////////////////////////////////////////////////////////
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(

                    // color: Colors.cyan,
                    child: Row(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(
                            Icons.phone,
                            color: Colors.grey[400],
                            size: 15,
                          ),
                        ),
                        const SizedBox(width: defaultPadding / 2),
                        Text(
                            whatsapp,
                            //'${snapshot.data!.docs[index]['phone']}',

                            // document['phone'],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                /////////////////////ABOUT////////////////////////////////////////////////////////////////////
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(

                    // color: Colors.cyan,
                    child: Row(
                      children: [
                        const SizedBox(width: defaultPadding / 2),
                        Text("kldjfljljld",
                            //'${snapshot.data!.docs[index]['about']}',

                            // document['about'],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                /////////////////Rating///////////////////////////////////////////////////////////
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    child: Row(
                      children: [
                        RatingBar(
                          minRating: 1,
                          maxRating: 5,
                          initialRating: 3,
                          allowHalfRating: true,
                          itemSize: 20,
                          // onRatingUpdate: _saveRating,
                          ratingWidget: RatingWidget(
                              full: Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              half: Image.asset('assets/heart_half.png'),
                              empty: Icon(
                                Icons.star,
                                color: Colors.grey,
                              )),
                          onRatingUpdate: (double value) {},
                        ),
                      ],
                    ),
                  ),
                ),
                //////////////////Social media ////////////////////////////////////////////////////////////
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 18,
                  ),
                  // color: Colors.cyan,
                  child: Row(
                    children: [

                      IconButton(
                        onPressed: () {
                          launch(facebook
                            //'${snapshot.data!.docs[index]['facebook']}',

                            //document["facebook"]
                          );
                        },
                        icon: Icon(
                          Icons.facebook_rounded,
                          color: Colors.blue[400],
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 90,
                      ),
                      IconButton(
                        onPressed: () {
                          Share.share('com.bikaam.bikaam');
                        },
                        icon: Icon(
                          Icons.share_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                ////////////////////////Follow///////////////////////////////////////////////////////////////////////
                //const SizedBox(height: 2),
                //FollowButton(value: document["uid"],),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget> [

                      //  BuildProfileButton(name: document['shopname'], image: document['imageUrl'], venderid:document['uid']),

                      InkWell(
                        onTap: () async {
                          /*  _auth = FirebaseAuth.instance;
                                            _user = _auth.currentUser;
                                            if (_user==null) {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));

                                            }else{
                                              getUsersData();
                                              FirebaseAuth auth= FirebaseAuth.instance;
                                              String uid=auth.currentUser!.uid.toString();
                                              Map <String,dynamic> data={"name":document["shopname"],"imageUrl":document['imageUrl'],"uid":uid,
                                                "coverUrl":document["coverUrl"],"venderid":document["uid"],"address":document['address'],"phone":document['phone'],
                                              };
                                              Map <String,dynamic> userdata={"name":firstName,"uid":uid,"isSelected":false
                                              };
                                              final coll= FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(value);
                                              if( ((await coll.get())!.exists)){
                                                var altertDialog = AlertDialog(
                                                  title: Row(children: [
                                                    Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                                                  ],),
                                                  content:
                                                  Text("انت بالفعل من متابعينا"),

                                                );
                                                showDialog(context: context, builder: (BuildContext context)
                                                {
                                                  return altertDialog;
                                                });
                                                //////////

                                              }else{
                                                FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(document['uid']).set(data);
                                                FirebaseFirestore.instance.collection(document['uid']).doc("followers").collection("followers").doc(uid).set(userdata);
                                                var altertDialog = AlertDialog(
                                                  title: Row(children: [
                                                    Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                                                  ],),
                                                  content:
                                                  Text("شكرا لانضمامك لعائلتنا "),

                                                );
                                                showDialog(context: context, builder: (BuildContext context)
                                                {
                                                  return altertDialog;
                                                });
                                              }
                                            }
*/
                        },
                        child: Container(


                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              Icon(Icons.person_add_alt_1,color: Colors.white,),
                              SizedBox(width: 7,),
                              Text("متابعة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                            ],
                          ),


                          color:Colors.blue ,
                          height: 45,
                          width:100,
                        ),
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: (){
                          _auth = FirebaseAuth.instance;
                          _user = _auth.currentUser;
                          if(_user==null){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                          }
                          else{
                            var altertDialog = AlertDialog(
                              backgroundColor: Color(0xFFECF2FF),
                              elevation: 20,
                              title: Row(children: [
                                Text("ارسال رسالة",style: TextStyle(color: Colors.black ,fontSize: 20,fontWeight: FontWeight.bold),),
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
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Container(
                                              height: 100,
                                              child: TextField(


                                                controller: _message,
                                                maxLines: null,
                                                keyboardType: TextInputType.multiline,
                                                //obscureText: true,

                                                decoration: InputDecoration(
                                                  helperMaxLines: 8,
                                                  contentPadding: EdgeInsets.only(top: 10,bottom: 20),
                                                  border: InputBorder.none,
                                                  hintText: 'اكتب رسالتك',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height:20,),

                                      GestureDetector(
                                        onTap: () async {
                                          /*
                                                            FirebaseAuth auth= FirebaseAuth.instance;
                                                            String uid=auth.currentUser!.uid.toString();
                                                            Map <String,dynamic> data={"message":_message.text,"uid":uid,"username":firstName};
                                                            FirebaseFirestore.instance.collection(document['uid']).doc("messages").collection("messages").add(data);
                                                            // FirebaseFirestore.instance.collection(uid).doc("orders").collection("orders").add(data);
                                                            Navigator.pop(context);*/

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

                          }

                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Icon(Icons.email,color: Colors.white,),
                                SizedBox(width: 5,),
                                Text("ارسال رسالة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                          color: Colors.red,
                          height: 45,
                          width: 120,
                        ),
                      ),
                      const SizedBox(width: 25),
                      InkWell(
                        onTap:(){
                          launch(
                            //'${snapshot.data!.docs[index]['shopname']}',

                              "whatsapp://send?phone=+2"+whatsapp
                            //'${snapshot.data!.docs[index]['phone']}'
                          );

                        } ,

                        //   child: IconButton(
                        //   onPressed: () {
                        //     launch("whatsapp://send?phone=+2"+document['phone']);
                        //   },
                        //   icon: Icon(
                        //     Icons.whatsapp,
                        //     color: Colors.green[400],
                        //     size: 40,
                        //   ),
                        // ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[100],
                          child:Icon(
                            Icons.whatsapp_outlined,
                            color: Colors.green[600],
                            size: 42,
                          ) ,

                        ),
                      )

                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

                ///////////////////Banner//////////////////////////////////////////////////////////////////////////
                //'${snapshot.data!.docs[index]['shopname']}',

                /*   '${snapshot.data!.docs[index]['shopname']}'==null? Image.network(
                            '${snapshot.data!.docs[index]['shopname']}',
                                    width: 300,
                                    fit: BoxFit.fill,
                                  ):Container(), */

                /*  document['banner']==null? Image.network(
                                    document['banner'],
                                    width: 300,
                                    fit: BoxFit.fill,
                                  ):Container(),*/

                /////////////////////////////////////////////////////////////////////////////////////////////////////

                ///////////////////list category//////////////////////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                      //border: Border.all(color: Colors.black12),
                    ),
                    // width: 400,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage2(cat:document['category'],value: value, )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text("الكل",style: TextStyle(color: Colors.white),),
                              )),
                            ),
                          ),
                        ),
                        ListCategory(value: value,),
                      ],
                    ),
                  ),
                ),
                // ListCategory(value:document['uid']),
                //////////////////////////////////////////
                /*   Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(

                                      // color: Colors.cyan,
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllProduct(value: value)));
                                        },
                                        child: Row(
                                          children: [
                                            const SizedBox(width: defaultPadding / 2),
                                            Text(" عرض الكل ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue[900])),
                                            Icon(Icons.arrow_back_ios_new_sharp,size: 17,color: Colors.blue[900],),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ), */
                ////////////////////List Products/////////////////////////////////////////////////////////////////////
                //   ListProducts(value:value),
                SizedBox(height: 10,),
                /////////////////////////////////////////////////////////////////////////////////////////////////////

              ],
            ),
          ),
        );
    },
      childCount: 1,
    ),),
          ListProducts(value: value),
    ],



    ),*/
      );*/


//           return Scaffold(
//             body: Container(
//               child: ListView(
//                 children: [
//                   Container(
//                     //height: 500,
//                     child: Column(
//                       children: [
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                         Stack(
//                           clipBehavior: Clip.none,
//                           //fit: StackFit.expand,
//                           children: [
//                             Container(
//                               // margin: const EdgeInsets.only(bottom: 50),
//                               height: 200,
//                               //color: Color(0xFFECF2FF),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                     bottomRight: Radius.circular(60),
//                                     bottomLeft: Radius.circular(30)),
//                                 color: Colors.black,
//                               ),
//                               child: Image.network(
//                                 //'${snapshot.data!.docs[index]['coverUrl']}',
//                                 cover,
//
//                                 //document['coverUrl'],
//                                 //height: 150,
//                                 width:350,
//                                 fit: BoxFit.fitWidth,
//                               ),
//                             ),
//                             Positioned(
//                               top: 90,
//                               left: 110,
//                               child: CircleAvatar(
//                                 radius: 70,
//                                 backgroundColor: Colors.grey[100],
//                                 backgroundImage:NetworkImage(
//                                   logo,
//                                   //'${snapshot.data!.docs[index]['imageUrl']}',
//                                   //document['imageUrl'],
//
//                                 ) ,
//                               ),
//                             ),
//                           ],
//                         ),
//                         //////////////////////name////////////////////////////////////////////////////////////////////
//                         SizedBox(
//                           height: 35,
//                         ),
//                         Text(name,
//                           // '${snapshot.data!.docs[index]['shopname']}',
//
//                           //document['shopname'],
//                           style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20,color: Colors.black),
//                         ),
//                         //////////////////address///////////////////////////////////////////////////////////////////////
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: Container(
//                             padding: EdgeInsets.only(
//                               left: 18,
//                             ),
//                             // color: Colors.cyan,
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset("assets/icons/Location.svg"),
//                                 const SizedBox(width: defaultPadding / 2),
//                                 Text(
//                                     address,
//                                     //'${snapshot.data!.docs[index]['address']}',
//
//                                     //document['address'],
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black)),
//                               ],
//                             ),
//                           ),
//                         ),
//                         ///////////////////phone////////////////////////////////////////////////////////////////////////////
//                         SizedBox(
//                           height: 7,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: Container(
//
//                             // color: Colors.cyan,
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding:
//                                   const EdgeInsets.symmetric(horizontal: 2.0),
//                                   child: Icon(
//                                     Icons.phone,
//                                     color: Colors.grey[400],
//                                     size: 15,
//                                   ),
//                                 ),
//                                 const SizedBox(width: defaultPadding / 2),
//                                 Text(
//                                     whatsapp,
//                                     //'${snapshot.data!.docs[index]['phone']}',
//
//                                     // document['phone'],
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black)),
//                               ],
//                             ),
//                           ),
//                         ),
//                         /////////////////////ABOUT////////////////////////////////////////////////////////////////////
//                         SizedBox(
//                           height: 7,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: Container(
//
//                             // color: Colors.cyan,
//                             child: Row(
//                               children: [
//                                 const SizedBox(width: defaultPadding / 2),
//                                 Text("kldjfljljld",
//                                     //'${snapshot.data!.docs[index]['about']}',
//
//                                     // document['about'],
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black)),
//                               ],
//                             ),
//                           ),
//                         ),
//                         /////////////////Rating///////////////////////////////////////////////////////////
//                         SizedBox(
//                           height: 7,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: Container(
//                             child: Row(
//                               children: [
//                                 RatingBar(
//                                   minRating: 1,
//                                   maxRating: 5,
//                                   initialRating: 3,
//                                   allowHalfRating: true,
//                                   itemSize: 20,
//                                   // onRatingUpdate: _saveRating,
//                                   ratingWidget: RatingWidget(
//                                       full: Icon(
//                                         Icons.star,
//                                         color: Colors.amber,
//                                       ),
//                                       half: Image.asset('assets/heart_half.png'),
//                                       empty: Icon(
//                                         Icons.star,
//                                         color: Colors.grey,
//                                       )),
//                                   onRatingUpdate: (double value) {},
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         //////////////////Social media ////////////////////////////////////////////////////////////
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(
//                             left: 18,
//                           ),
//                           // color: Colors.cyan,
//                           child: Row(
//                             children: [
//
//                               IconButton(
//                                 onPressed: () {
//                                   launch(facebook
//                                     //'${snapshot.data!.docs[index]['facebook']}',
//
//                                     //document["facebook"]
//                                   );
//                                 },
//                                 icon: Icon(
//                                   Icons.facebook_rounded,
//                                   color: Colors.blue[400],
//                                   size: 30,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 90,
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   Share.share('com.bikaam.bikaam');
//                                 },
//                                 icon: Icon(
//                                   Icons.share_outlined,
//                                   color: Colors.black,
//                                   size: 30,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         ////////////////////////Follow///////////////////////////////////////////////////////////////////////
//                         //const SizedBox(height: 2),
//                         //FollowButton(value: document["uid"],),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: <Widget> [
//
//                               //  BuildProfileButton(name: document['shopname'], image: document['imageUrl'], venderid:document['uid']),
//
//                               InkWell(
//                                 onTap: () async {
//                                   /*  _auth = FirebaseAuth.instance;
//                                         _user = _auth.currentUser;
//                                         if (_user==null) {
//                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
//
//                                         }else{
//                                           getUsersData();
//                                           FirebaseAuth auth= FirebaseAuth.instance;
//                                           String uid=auth.currentUser!.uid.toString();
//                                           Map <String,dynamic> data={"name":document["shopname"],"imageUrl":document['imageUrl'],"uid":uid,
//                                             "coverUrl":document["coverUrl"],"venderid":document["uid"],"address":document['address'],"phone":document['phone'],
//                                           };
//                                           Map <String,dynamic> userdata={"name":firstName,"uid":uid,"isSelected":false
//                                           };
//                                           final coll= FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(value);
//                                           if( ((await coll.get())!.exists)){
//                                             var altertDialog = AlertDialog(
//                                               title: Row(children: [
//                                                 Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
//                                               ],),
//                                               content:
//                                               Text("انت بالفعل من متابعينا"),
//
//                                             );
//                                             showDialog(context: context, builder: (BuildContext context)
//                                             {
//                                               return altertDialog;
//                                             });
//                                             //////////
//
//                                           }else{
//                                             FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(document['uid']).set(data);
//                                             FirebaseFirestore.instance.collection(document['uid']).doc("followers").collection("followers").doc(uid).set(userdata);
//                                             var altertDialog = AlertDialog(
//                                               title: Row(children: [
//                                                 Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
//                                               ],),
//                                               content:
//                                               Text("شكرا لانضمامك لعائلتنا "),
//
//                                             );
//                                             showDialog(context: context, builder: (BuildContext context)
//                                             {
//                                               return altertDialog;
//                                             });
//                                           }
//                                         }
// */
//                                 },
//                                 child: Container(
//
//
//                                   child: Row(
//                                     children: [
//                                       SizedBox(width: 5,),
//                                       Icon(Icons.person_add_alt_1,color: Colors.white,),
//                                       SizedBox(width: 7,),
//                                       Text("متابعة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
//                                     ],
//                                   ),
//
//
//                                   color:Colors.blue ,
//                                   height: 45,
//                                   width:100,
//                                 ),
//                               ),
//                               const SizedBox(width: 15),
//                               InkWell(
//                                 onTap: (){
//                                   _auth = FirebaseAuth.instance;
//                                   _user = _auth.currentUser;
//                                   if(_user==null){
//                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
//                                   }
//                                   else{
//                                     var altertDialog = AlertDialog(
//                                       backgroundColor: Color(0xFFECF2FF),
//                                       elevation: 20,
//                                       title: Row(children: [
//                                         Text("ارسال رسالة",style: TextStyle(color: Colors.black ,fontSize: 20,fontWeight: FontWeight.bold),),
//                                         //Text(document['code'],style: TextStyle(color: Colors.black,fontSize: 20),),
//                                       ],),
//
//                                       content:
//                                       Container(
//                                           height:200,
//
//                                           color: Color(0xFFECF2FF),
//                                           child: Column(
//                                             children: [
//                                               //SizedBox(height: 10,),
//                                               Padding(
//                                                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                                                 child: Container(
//                                                   // width: 200,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.white,
//                                                     borderRadius: BorderRadius.circular(12),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                                                     child: Container(
//                                                       height: 100,
//                                                       child: TextField(
//
//
//                                                         controller: _message,
//                                                         maxLines: null,
//                                                         keyboardType: TextInputType.multiline,
//                                                         //obscureText: true,
//
//                                                         decoration: InputDecoration(
//                                                           helperMaxLines: 8,
//                                                           contentPadding: EdgeInsets.only(top: 10,bottom: 20),
//                                                           border: InputBorder.none,
//                                                           hintText: 'اكتب رسالتك',
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(height:20,),
//
//                                               GestureDetector(
//                                                 onTap: () async {
//                                                   /*
//                                                         FirebaseAuth auth= FirebaseAuth.instance;
//                                                         String uid=auth.currentUser!.uid.toString();
//                                                         Map <String,dynamic> data={"message":_message.text,"uid":uid,"username":firstName};
//                                                         FirebaseFirestore.instance.collection(document['uid']).doc("messages").collection("messages").add(data);
//                                                         // FirebaseFirestore.instance.collection(uid).doc("orders").collection("orders").add(data);
//                                                         Navigator.pop(context);*/
//
//                                                 },
//                                                 child: Container(
//                                                   height: 30,
//                                                   width: 170,
//
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.blue[700],
//                                                     borderRadius: BorderRadius.circular(12),
//                                                   ),
//                                                   child:
//                                                   Center(child: Text("ارسال",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
//                                                 ),
//
//                                               ),
//                                             ],
//                                           )
//                                       ),
//
//
//                                     );
//                                     showDialog(context: context, builder: (BuildContext context)
//                                     {
//                                       return altertDialog;
//                                     });
//
//                                   }
//
//                                 },
//                                 child: Container(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(6.0),
//                                     child: Row(
//                                       children: [
//                                         Icon(Icons.email,color: Colors.white,),
//                                         SizedBox(width: 5,),
//                                         Text("ارسال رسالة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//                                       ],
//                                     ),
//                                   ),
//                                   color: Colors.red,
//                                   height: 45,
//                                   width: 120,
//                                 ),
//                               ),
//                               const SizedBox(width: 25),
//                               InkWell(
//                                 onTap:(){
//                                   launch(
//                                     //'${snapshot.data!.docs[index]['shopname']}',
//
//                                       "whatsapp://send?phone=+2"+whatsapp
//                                     //'${snapshot.data!.docs[index]['phone']}'
//                                   );
//
//                                 } ,
//
//                                 //   child: IconButton(
//                                 //   onPressed: () {
//                                 //     launch("whatsapp://send?phone=+2"+document['phone']);
//                                 //   },
//                                 //   icon: Icon(
//                                 //     Icons.whatsapp,
//                                 //     color: Colors.green[400],
//                                 //     size: 40,
//                                 //   ),
//                                 // ),
//                                 child: CircleAvatar(
//                                   radius: 30,
//                                   backgroundColor: Colors.grey[100],
//                                   child:Icon(
//                                     Icons.whatsapp_outlined,
//                                     color: Colors.green[600],
//                                     size: 42,
//                                   ) ,
//
//                                 ),
//                               )
//
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//
//                         ///////////////////Banner//////////////////////////////////////////////////////////////////////////
//                         //'${snapshot.data!.docs[index]['shopname']}',
//
//                         /*   '${snapshot.data!.docs[index]['shopname']}'==null? Image.network(
//                         '${snapshot.data!.docs[index]['shopname']}',
//                                 width: 300,
//                                 fit: BoxFit.fill,
//                               ):Container(), */
//
//                         /*  document['banner']==null? Image.network(
//                                 document['banner'],
//                                 width: 300,
//                                 fit: BoxFit.fill,
//                               ):Container(),*/
//
//                         /////////////////////////////////////////////////////////////////////////////////////////////////////
//
//                         ///////////////////list category//////////////////////////////////////////////////////////////////////
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 5.0),
//                           child: Container(
//                             height: 45,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(2),
//                               color: Colors.white,
//                               //border: Border.all(color: Colors.black12),
//                             ),
//                             // width: 400,
//                             child: Row(
//                               children: [
//                                 InkWell(
//                                   onTap: (){
//                                     //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage2(cat:document['category'],value: value, )));
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                     child: Container(
//                                       width: 50,
//                                       height: 30,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.blue,
//                                         border: Border.all(color: Colors.black12),
//                                       ),
//                                       child: Center(child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                                         child: Text("الكل",style: TextStyle(color: Colors.white),),
//                                       )),
//                                     ),
//                                   ),
//                                 ),
//                                 ListCategory(value: value,),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // ListCategory(value:document['uid']),
//                         //////////////////////////////////////////
//                         /*   Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: Container(
//
//                                   // color: Colors.cyan,
//                                   child: InkWell(
//                                     onTap: (){
//                                       Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllProduct(value: value)));
//                                     },
//                                     child: Row(
//                                       children: [
//                                         const SizedBox(width: defaultPadding / 2),
//                                         Text(" عرض الكل ",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.blue[900])),
//                                         Icon(Icons.arrow_back_ios_new_sharp,size: 17,color: Colors.blue[900],),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ), */
//                         ////////////////////List Products/////////////////////////////////////////////////////////////////////
//                         //   ListProducts(value:value),
//                         SizedBox(height: 10,),
//                         /////////////////////////////////////////////////////////////////////////////////////////////////////
//
//                       ],
//                     ),
//                   ),
//                   ListProducts(value:value),
// //                   CustomScrollView(
// //                       //pushPinnedChildren: true,
// //                       slivers: [
// //
// //                         SliverList(delegate: SliverChildBuilderDelegate(
// //                       (BuildContext context , int index){
// //                         return Container(
// //                           //height: 500,
// //                           child: Column(
// //                             children: [
// // ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// //                               Stack(
// //                                 clipBehavior: Clip.none,
// //                                 //fit: StackFit.expand,
// //                                 children: [
// //                                   Container(
// //                                     // margin: const EdgeInsets.only(bottom: 50),
// //                                     height: 200,
// //                                     //color: Color(0xFFECF2FF),
// //                                     decoration: BoxDecoration(
// //                                       borderRadius: BorderRadius.only(
// //                                           bottomRight: Radius.circular(60),
// //                                           bottomLeft: Radius.circular(30)),
// //                                       color: Colors.black,
// //                                     ),
// //                                     child: Image.network(
// //                                       //'${snapshot.data!.docs[index]['coverUrl']}',
// //                                       cover,
// //
// //                                       //document['coverUrl'],
// //                                       //height: 150,
// //                                       width:350,
// //                                       fit: BoxFit.fitWidth,
// //                                     ),
// //                                   ),
// //                                   Positioned(
// //                                     top: 90,
// //                                     left: 110,
// //                                     child: CircleAvatar(
// //                                       radius: 70,
// //                                       backgroundColor: Colors.grey[100],
// //                                       backgroundImage:NetworkImage(
// //                                         logo,
// //                                         //'${snapshot.data!.docs[index]['imageUrl']}',
// //                                         //document['imageUrl'],
// //
// //                                       ) ,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               //////////////////////name////////////////////////////////////////////////////////////////////
// //                               SizedBox(
// //                                 height: 35,
// //                               ),
// //                               Text(name,
// //                                // '${snapshot.data!.docs[index]['shopname']}',
// //
// //                                 //document['shopname'],
// //                                 style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20,color: Colors.black),
// //                               ),
// //                               //////////////////address///////////////////////////////////////////////////////////////////////
// //                               SizedBox(
// //                                 height: 10,
// //                               ),
// //                               Padding(
// //                                 padding: const EdgeInsets.only(right: 8.0),
// //                                 child: Container(
// //                                   padding: EdgeInsets.only(
// //                                     left: 18,
// //                                   ),
// //                                   // color: Colors.cyan,
// //                                   child: Row(
// //                                     children: [
// //                                       SvgPicture.asset("assets/icons/Location.svg"),
// //                                       const SizedBox(width: defaultPadding / 2),
// //                                       Text(
// //                                         address,
// //                                           //'${snapshot.data!.docs[index]['address']}',
// //
// //                                           //document['address'],
// //                                           style: TextStyle(
// //                                               fontSize: 15,
// //                                               fontWeight: FontWeight.bold,
// //                                               color: Colors.black)),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                               ///////////////////phone////////////////////////////////////////////////////////////////////////////
// //                               SizedBox(
// //                                 height: 7,
// //                               ),
// //                               Padding(
// //                                 padding: const EdgeInsets.only(right: 8.0),
// //                                 child: Container(
// //
// //                                   // color: Colors.cyan,
// //                                   child: Row(
// //                                     children: [
// //                                       Padding(
// //                                         padding:
// //                                         const EdgeInsets.symmetric(horizontal: 2.0),
// //                                         child: Icon(
// //                                           Icons.phone,
// //                                           color: Colors.grey[400],
// //                                           size: 15,
// //                                         ),
// //                                       ),
// //                                       const SizedBox(width: defaultPadding / 2),
// //                                       Text(
// //                                         whatsapp,
// //                                           //'${snapshot.data!.docs[index]['phone']}',
// //
// //                                          // document['phone'],
// //                                           style: TextStyle(
// //                                               fontSize: 15,
// //                                               fontWeight: FontWeight.bold,
// //                                               color: Colors.black)),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                               /////////////////////ABOUT////////////////////////////////////////////////////////////////////
// //                               SizedBox(
// //                                 height: 7,
// //                               ),
// //                               Padding(
// //                                 padding: const EdgeInsets.only(right: 8.0),
// //                                 child: Container(
// //
// //                                   // color: Colors.cyan,
// //                                   child: Row(
// //                                     children: [
// //                                       const SizedBox(width: defaultPadding / 2),
// //                                       Text("kldjfljljld",
// //                                           //'${snapshot.data!.docs[index]['about']}',
// //
// //                                          // document['about'],
// //                                           style: TextStyle(
// //                                               fontSize: 15,
// //                                               fontWeight: FontWeight.bold,
// //                                               color: Colors.black)),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                               /////////////////Rating///////////////////////////////////////////////////////////
// //                               SizedBox(
// //                                 height: 7,
// //                               ),
// //                               Padding(
// //                                 padding: const EdgeInsets.only(right: 8.0),
// //                                 child: Container(
// //                                   child: Row(
// //                                     children: [
// //                                       RatingBar(
// //                                         minRating: 1,
// //                                         maxRating: 5,
// //                                         initialRating: 3,
// //                                         allowHalfRating: true,
// //                                         itemSize: 20,
// //                                         // onRatingUpdate: _saveRating,
// //                                         ratingWidget: RatingWidget(
// //                                             full: Icon(
// //                                               Icons.star,
// //                                               color: Colors.amber,
// //                                             ),
// //                                             half: Image.asset('assets/heart_half.png'),
// //                                             empty: Icon(
// //                                               Icons.star,
// //                                               color: Colors.grey,
// //                                             )),
// //                                         onRatingUpdate: (double value) {},
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                               //////////////////Social media ////////////////////////////////////////////////////////////
// //                               SizedBox(
// //                                 height: 5,
// //                               ),
// //                               Container(
// //                                 padding: EdgeInsets.only(
// //                                   left: 18,
// //                                 ),
// //                                 // color: Colors.cyan,
// //                                 child: Row(
// //                                   children: [
// //
// //                                     IconButton(
// //                                       onPressed: () {
// //                                         launch(facebook
// //                                             //'${snapshot.data!.docs[index]['facebook']}',
// //
// //                                             //document["facebook"]
// //                                         );
// //                                       },
// //                                       icon: Icon(
// //                                         Icons.facebook_rounded,
// //                                         color: Colors.blue[400],
// //                                         size: 30,
// //                                       ),
// //                                     ),
// //                                     SizedBox(
// //                                       width: 90,
// //                                     ),
// //                                     IconButton(
// //                                       onPressed: () {
// //                                         Share.share('com.bikaam.bikaam');
// //                                       },
// //                                       icon: Icon(
// //                                         Icons.share_outlined,
// //                                         color: Colors.black,
// //                                         size: 30,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                               ////////////////////////Follow///////////////////////////////////////////////////////////////////////
// //                               //const SizedBox(height: 2),
// //                               //FollowButton(value: document["uid"],),
// //                               Padding(
// //                                 padding: const EdgeInsets.only(right: 8.0),
// //                                 child: Row(
// //                                   mainAxisAlignment: MainAxisAlignment.start,
// //                                   children: <Widget> [
// //
// //                                     //  BuildProfileButton(name: document['shopname'], image: document['imageUrl'], venderid:document['uid']),
// //
// //                                     InkWell(
// //                                       onTap: () async {
// //                                       /*  _auth = FirebaseAuth.instance;
// //                                         _user = _auth.currentUser;
// //                                         if (_user==null) {
// //                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
// //
// //                                         }else{
// //                                           getUsersData();
// //                                           FirebaseAuth auth= FirebaseAuth.instance;
// //                                           String uid=auth.currentUser!.uid.toString();
// //                                           Map <String,dynamic> data={"name":document["shopname"],"imageUrl":document['imageUrl'],"uid":uid,
// //                                             "coverUrl":document["coverUrl"],"venderid":document["uid"],"address":document['address'],"phone":document['phone'],
// //                                           };
// //                                           Map <String,dynamic> userdata={"name":firstName,"uid":uid,"isSelected":false
// //                                           };
// //                                           final coll= FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(value);
// //                                           if( ((await coll.get())!.exists)){
// //                                             var altertDialog = AlertDialog(
// //                                               title: Row(children: [
// //                                                 Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
// //                                               ],),
// //                                               content:
// //                                               Text("انت بالفعل من متابعينا"),
// //
// //                                             );
// //                                             showDialog(context: context, builder: (BuildContext context)
// //                                             {
// //                                               return altertDialog;
// //                                             });
// //                                             //////////
// //
// //                                           }else{
// //                                             FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(document['uid']).set(data);
// //                                             FirebaseFirestore.instance.collection(document['uid']).doc("followers").collection("followers").doc(uid).set(userdata);
// //                                             var altertDialog = AlertDialog(
// //                                               title: Row(children: [
// //                                                 Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
// //                                               ],),
// //                                               content:
// //                                               Text("شكرا لانضمامك لعائلتنا "),
// //
// //                                             );
// //                                             showDialog(context: context, builder: (BuildContext context)
// //                                             {
// //                                               return altertDialog;
// //                                             });
// //                                           }
// //                                         }
// // */
// //                                       },
// //                                       child: Container(
// //
// //
// //                                         child: Row(
// //                                           children: [
// //                                             SizedBox(width: 5,),
// //                                             Icon(Icons.person_add_alt_1,color: Colors.white,),
// //                                             SizedBox(width: 7,),
// //                                             Text("متابعة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
// //                                           ],
// //                                         ),
// //
// //
// //                                         color:Colors.blue ,
// //                                         height: 45,
// //                                         width:100,
// //                                       ),
// //                                     ),
// //                                     const SizedBox(width: 15),
// //                                     InkWell(
// //                                       onTap: (){
// //                                         _auth = FirebaseAuth.instance;
// //                                         _user = _auth.currentUser;
// //                                         if(_user==null){
// //                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
// //                                         }
// //                                         else{
// //                                           var altertDialog = AlertDialog(
// //                                             backgroundColor: Color(0xFFECF2FF),
// //                                             elevation: 20,
// //                                             title: Row(children: [
// //                                               Text("ارسال رسالة",style: TextStyle(color: Colors.black ,fontSize: 20,fontWeight: FontWeight.bold),),
// //                                               //Text(document['code'],style: TextStyle(color: Colors.black,fontSize: 20),),
// //                                             ],),
// //
// //                                             content:
// //                                             Container(
// //                                                 height:200,
// //
// //                                                 color: Color(0xFFECF2FF),
// //                                                 child: Column(
// //                                                   children: [
// //                                                     //SizedBox(height: 10,),
// //                                                     Padding(
// //                                                       padding: const EdgeInsets.symmetric(horizontal: 10),
// //                                                       child: Container(
// //                                                         // width: 200,
// //                                                         decoration: BoxDecoration(
// //                                                           color: Colors.white,
// //                                                           borderRadius: BorderRadius.circular(12),
// //                                                         ),
// //                                                         child: Padding(
// //                                                           padding: const EdgeInsets.symmetric(horizontal: 20),
// //                                                           child: Container(
// //                                                             height: 100,
// //                                                             child: TextField(
// //
// //
// //                                                               controller: _message,
// //                                                               maxLines: null,
// //                                                               keyboardType: TextInputType.multiline,
// //                                                               //obscureText: true,
// //
// //                                                               decoration: InputDecoration(
// //                                                                 helperMaxLines: 8,
// //                                                                 contentPadding: EdgeInsets.only(top: 10,bottom: 20),
// //                                                                 border: InputBorder.none,
// //                                                                 hintText: 'اكتب رسالتك',
// //                                                               ),
// //                                                             ),
// //                                                           ),
// //                                                         ),
// //                                                       ),
// //                                                     ),
// //                                                     SizedBox(height:20,),
// //
// //                                                     GestureDetector(
// //                                                       onTap: () async {
// //                                                      /*
// //                                                         FirebaseAuth auth= FirebaseAuth.instance;
// //                                                         String uid=auth.currentUser!.uid.toString();
// //                                                         Map <String,dynamic> data={"message":_message.text,"uid":uid,"username":firstName};
// //                                                         FirebaseFirestore.instance.collection(document['uid']).doc("messages").collection("messages").add(data);
// //                                                         // FirebaseFirestore.instance.collection(uid).doc("orders").collection("orders").add(data);
// //                                                         Navigator.pop(context);*/
// //
// //                                                       },
// //                                                       child: Container(
// //                                                         height: 30,
// //                                                         width: 170,
// //
// //                                                         decoration: BoxDecoration(
// //                                                           color: Colors.blue[700],
// //                                                           borderRadius: BorderRadius.circular(12),
// //                                                         ),
// //                                                         child:
// //                                                         Center(child: Text("ارسال",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
// //                                                       ),
// //
// //                                                     ),
// //                                                   ],
// //                                                 )
// //                                             ),
// //
// //
// //                                           );
// //                                           showDialog(context: context, builder: (BuildContext context)
// //                                           {
// //                                             return altertDialog;
// //                                           });
// //
// //                                         }
// //
// //                                       },
// //                                       child: Container(
// //                                         child: Padding(
// //                                           padding: const EdgeInsets.all(6.0),
// //                                           child: Row(
// //                                             children: [
// //                                               Icon(Icons.email,color: Colors.white,),
// //                                               SizedBox(width: 5,),
// //                                               Text("ارسال رسالة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
// //                                             ],
// //                                           ),
// //                                         ),
// //                                         color: Colors.red,
// //                                         height: 45,
// //                                         width: 120,
// //                                       ),
// //                                     ),
// //                                     const SizedBox(width: 25),
// //                                     InkWell(
// //                                       onTap:(){
// //                                         launch(
// //                                             //'${snapshot.data!.docs[index]['shopname']}',
// //
// //                                             "whatsapp://send?phone=+2"+whatsapp
// //                                                 //'${snapshot.data!.docs[index]['phone']}'
// //                                         );
// //
// //                                       } ,
// //
// //                                       //   child: IconButton(
// //                                       //   onPressed: () {
// //                                       //     launch("whatsapp://send?phone=+2"+document['phone']);
// //                                       //   },
// //                                       //   icon: Icon(
// //                                       //     Icons.whatsapp,
// //                                       //     color: Colors.green[400],
// //                                       //     size: 40,
// //                                       //   ),
// //                                       // ),
// //                                       child: CircleAvatar(
// //                                         radius: 30,
// //                                         backgroundColor: Colors.grey[100],
// //                                         child:Icon(
// //                                           Icons.whatsapp_outlined,
// //                                           color: Colors.green[600],
// //                                           size: 42,
// //                                         ) ,
// //
// //                                       ),
// //                                     )
// //
// //                                   ],
// //                                 ),
// //                               ),
// //                               SizedBox(
// //                                 height: 5,
// //                               ),
// //
// //                               ///////////////////Banner//////////////////////////////////////////////////////////////////////////
// //                               //'${snapshot.data!.docs[index]['shopname']}',
// //
// //                        /*   '${snapshot.data!.docs[index]['shopname']}'==null? Image.network(
// //                         '${snapshot.data!.docs[index]['shopname']}',
// //                                 width: 300,
// //                                 fit: BoxFit.fill,
// //                               ):Container(), */
// //
// //                               /*  document['banner']==null? Image.network(
// //                                 document['banner'],
// //                                 width: 300,
// //                                 fit: BoxFit.fill,
// //                               ):Container(),*/
// //
// //                               /////////////////////////////////////////////////////////////////////////////////////////////////////
// //
// //                               ///////////////////list category//////////////////////////////////////////////////////////////////////
// //                                 Padding(
// //                                 padding: const EdgeInsets.only(bottom: 5.0),
// //                                 child: Container(
// //                                   height: 45,
// //                                   decoration: BoxDecoration(
// //                                     borderRadius: BorderRadius.circular(2),
// //                                     color: Colors.white,
// //                                     //border: Border.all(color: Colors.black12),
// //                                   ),
// //                                   // width: 400,
// //                                   child: Row(
// //                                     children: [
// //                                       InkWell(
// //                                         onTap: (){
// //                                           //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage2(cat:document['category'],value: value, )));
// //                                         },
// //                                         child: Padding(
// //                                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
// //                                           child: Container(
// //                                             width: 50,
// //                                             height: 30,
// //                                             decoration: BoxDecoration(
// //                                               borderRadius: BorderRadius.circular(10),
// //                                               color: Colors.blue,
// //                                               border: Border.all(color: Colors.black12),
// //                                             ),
// //                                             child: Center(child: Padding(
// //                                               padding: const EdgeInsets.symmetric(horizontal: 10.0),
// //                                               child: Text("الكل",style: TextStyle(color: Colors.white),),
// //                                             )),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       ListCategory(value: value,),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                               // ListCategory(value:document['uid']),
// //                               //////////////////////////////////////////
// //                               /*   Padding(
// //                                 padding: const EdgeInsets.only(right: 8.0),
// //                                 child: Container(
// //
// //                                   // color: Colors.cyan,
// //                                   child: InkWell(
// //                                     onTap: (){
// //                                       Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllProduct(value: value)));
// //                                     },
// //                                     child: Row(
// //                                       children: [
// //                                         const SizedBox(width: defaultPadding / 2),
// //                                         Text(" عرض الكل ",
// //                                             style: TextStyle(
// //                                                 fontSize: 15,
// //                                                 fontWeight: FontWeight.bold,
// //                                                 color: Colors.blue[900])),
// //                                         Icon(Icons.arrow_back_ios_new_sharp,size: 17,color: Colors.blue[900],),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ), */
// //                               ////////////////////List Products/////////////////////////////////////////////////////////////////////
// //                             //   ListProducts(value:value),
// //                               SizedBox(height: 10,),
// //                               /////////////////////////////////////////////////////////////////////////////////////////////////////
// //
// //                             ],
// //                           ),
// //                         );
// //                       }
// //                     )),
// //                       //  ListProducts(value:value),
// //                   ] ),
//                 ],
//               ),
//             ),
//           );
      /*   },
      ),
    );*/
  /*  return MultiSliver(
      pushPinnedChildren: true,
      children:<Widget> [
    SliverList(delegate: SliverChildBuilderDelegate(
    ( context ,  index){
      return StreamBuilder(
          stream: ref.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text(
                'no values',
                style: TextStyle(color: Colors.black),
              );
            }
            return ListView(
              //padding: EdgeInsets.all(30),
              children: snapshot.data!.docs.map((document) {

                return Container(
                  //height: 500,

                  child: Column(
                    children: [
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      Stack(
                        clipBehavior: Clip.none,
                        //fit: StackFit.expand,
                        children: [
                          Container(
                            // margin: const EdgeInsets.only(bottom: 50),
                            height: 200,
                            //color: Color(0xFFECF2FF),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(60),
                                  bottomLeft: Radius.circular(30)),
                              color: Colors.black,
                            ),
                            child: Image.network(
                              document['coverUrl'],
                              //height: 150,
                              width:350,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Positioned(
                            top: 90,
                            left: 110,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.grey[100],
                              backgroundImage:NetworkImage(
                                document['imageUrl'],

                              ) ,
                            ),
                          ),
                        ],
                      ),
                      //////////////////////name////////////////////////////////////////////////////////////////////
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        document['shopname'],
                        style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20,color: Colors.black),
                      ),
                      //////////////////address///////////////////////////////////////////////////////////////////////
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 18,
                          ),
                          // color: Colors.cyan,
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/Location.svg"),
                              const SizedBox(width: defaultPadding / 2),
                              Text(document['address'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      ///////////////////phone////////////////////////////////////////////////////////////////////////////
                      SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(

                          // color: Colors.cyan,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.grey[400],
                                  size: 15,
                                ),
                              ),
                              const SizedBox(width: defaultPadding / 2),
                              Text(document['phone'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      /////////////////////ABOUT////////////////////////////////////////////////////////////////////
                      SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(

                          // color: Colors.cyan,
                          child: Row(
                            children: [
                              const SizedBox(width: defaultPadding / 2),
                              Text(document['about'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      /////////////////Rating///////////////////////////////////////////////////////////
                      SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          child: Row(
                            children: [
                              RatingBar(
                                minRating: 1,
                                maxRating: 5,
                                initialRating: 3,
                                allowHalfRating: true,
                                itemSize: 20,
                                // onRatingUpdate: _saveRating,
                                ratingWidget: RatingWidget(
                                    full: Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    half: Image.asset('assets/heart_half.png'),
                                    empty: Icon(
                                      Icons.star,
                                      color: Colors.grey,
                                    )),
                                onRatingUpdate: (double value) {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      //////////////////Social media ////////////////////////////////////////////////////////////
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 18,
                        ),
                        // color: Colors.cyan,
                        child: Row(
                          children: [

                            IconButton(
                              onPressed: () {
                                launch(document["facebook"]);
                              },
                              icon: Icon(
                                Icons.facebook_rounded,
                                color: Colors.blue[400],
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              width: 90,
                            ),
                            IconButton(
                              onPressed: () {
                                Share.share('com.bikaam.bikaam');
                              },
                              icon: Icon(
                                Icons.share_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ////////////////////////Follow///////////////////////////////////////////////////////////////////////
                      //const SizedBox(height: 2),
                      //FollowButton(value: document["uid"],),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget> [

                            //  BuildProfileButton(name: document['shopname'], image: document['imageUrl'], venderid:document['uid']),

                            InkWell(
                              onTap: () async {
                                _auth = FirebaseAuth.instance;
                                _user = _auth.currentUser;
                                if (_user==null) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));

                                }else{
                                  getUsersData();
                                  FirebaseAuth auth= FirebaseAuth.instance;
                                  String uid=auth.currentUser!.uid.toString();
                                  Map <String,dynamic> data={"name":document["shopname"],"imageUrl":document['imageUrl'],"uid":uid,
                                    "coverUrl":document["coverUrl"],"venderid":document["uid"],"address":document['address'],"phone":document['phone'],
                                  };
                                  Map <String,dynamic> userdata={"name":firstName,"uid":uid,"isSelected":false
                                  };
                                  final coll= FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(value);
                                  if( ((await coll.get())!.exists)){
                                    var altertDialog = AlertDialog(
                                      title: Row(children: [
                                        Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                                      ],),
                                      content:
                                      Text("انت بالفعل من متابعينا"),

                                    );
                                    showDialog(context: context, builder: (BuildContext context)
                                    {
                                      return altertDialog;
                                    });
                                    //////////

                                  }else{
                                    FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(document['uid']).set(data);
                                    FirebaseFirestore.instance.collection(document['uid']).doc("followers").collection("followers").doc(uid).set(userdata);
                                    var altertDialog = AlertDialog(
                                      title: Row(children: [
                                        Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                                      ],),
                                      content:
                                      Text("شكرا لانضمامك لعائلتنا "),

                                    );
                                    showDialog(context: context, builder: (BuildContext context)
                                    {
                                      return altertDialog;
                                    });
                                  }
                                }

                              },
                              child: Container(


                                child: Row(
                                  children: [
                                    SizedBox(width: 5,),
                                    Icon(Icons.person_add_alt_1,color: Colors.white,),
                                    SizedBox(width: 7,),
                                    Text("متابعة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                  ],
                                ),


                                color:Colors.blue ,
                                height: 45,
                                width:100,
                              ),
                            ),
                            const SizedBox(width: 15),
                            InkWell(
                              onTap: (){
                                _auth = FirebaseAuth.instance;
                                _user = _auth.currentUser;
                                if(_user==null){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                                }
                                else{
                                  var altertDialog = AlertDialog(
                                    backgroundColor: Color(0xFFECF2FF),
                                    elevation: 20,
                                    title: Row(children: [
                                      Text("ارسال رسالة",style: TextStyle(color: Colors.black ,fontSize: 20,fontWeight: FontWeight.bold),),
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
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                  child: Container(
                                                    height: 100,
                                                    child: TextField(


                                                      controller: _message,
                                                      maxLines: null,
                                                      keyboardType: TextInputType.multiline,
                                                      //obscureText: true,

                                                      decoration: InputDecoration(
                                                        helperMaxLines: 8,
                                                        contentPadding: EdgeInsets.only(top: 10,bottom: 20),
                                                        border: InputBorder.none,
                                                        hintText: 'اكتب رسالتك',
                                                      ),
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
                                                Map <String,dynamic> data={"message":_message.text,"uid":uid,"username":firstName};
                                                FirebaseFirestore.instance.collection(document['uid']).doc("messages").collection("messages").add(data);
                                                // FirebaseFirestore.instance.collection(uid).doc("orders").collection("orders").add(data);
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

                                }

                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.email,color: Colors.white,),
                                      SizedBox(width: 5,),
                                      Text("ارسال رسالة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                color: Colors.red,
                                height: 45,
                                width: 120,
                              ),
                            ),
                            const SizedBox(width: 25),
                            InkWell(
                              onTap:(){
                                launch("whatsapp://send?phone=+2"+document['phone']);

                              } ,

                              //   child: IconButton(
                              //   onPressed: () {
                              //     launch("whatsapp://send?phone=+2"+document['phone']);
                              //   },
                              //   icon: Icon(
                              //     Icons.whatsapp,
                              //     color: Colors.green[400],
                              //     size: 40,
                              //   ),
                              // ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey[100],
                                child:Icon(
                                  Icons.whatsapp_outlined,
                                  color: Colors.green[600],
                                  size: 42,
                                ) ,

                              ),
                            )

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ///////////////////Banner//////////////////////////////////////////////////////////////////////////
                      document['banner']==null? Image.network(
                        document['banner'],
                        width: 300,
                        fit: BoxFit.fill,
                      ):Container(),

                      /////////////////////////////////////////////////////////////////////////////////////////////////////

                      ///////////////////list category//////////////////////////////////////////////////////////////////////
                    /*  Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.white,
                            //border: Border.all(color: Colors.black12),
                          ),
                          // width: 400,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage2(cat:document['category'],value: value, )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Container(
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue,
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Center(child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text("الكل",style: TextStyle(color: Colors.white),),
                                    )),
                                  ),
                                ),
                              ),
                              ListCategory(value: value,),
                            ],
                          ),
                        ),
                      ),*/
                      // ListCategory(value:document['uid']),
                      //////////////////////////////////////////
                   /*   Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(

                          // color: Colors.cyan,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllProduct(value: value)));
                            },
                            child: Row(
                              children: [
                                const SizedBox(width: defaultPadding / 2),
                                Text(" عرض الكل ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[900])),
                                Icon(Icons.arrow_back_ios_new_sharp,size: 17,color: Colors.blue[900],),
                              ],
                            ),
                          ),
                        ),
                      ), */
                      ////////////////////List Products/////////////////////////////////////////////////////////////////////
                    //  ListProducts(value:value),
                      SizedBox(height: 10,),
                      /////////////////////////////////////////////////////////////////////////////////////////////////////

                    ],
                  ),
                );
              }).toList(),
            );
          });
    }
    ),),

    ],



    );  */
   /* return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          body: Stack(
            children: [

                 Builder(
                    builder: (context) {
                      return StreamBuilder(
                          stream: ref.snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                'no values',
                                style: TextStyle(color: Colors.black),
                              );
                            }
                            return ListView(
                              //padding: EdgeInsets.all(30),
                              children: snapshot.data!.docs.map((document) {

                                return Container(
                                  //height: 500,

                                  child: Column(
                                    children: [

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                      Stack(
                                        clipBehavior: Clip.none,
                                        //fit: StackFit.expand,
                                        children: [
                                          Container(
                                            // margin: const EdgeInsets.only(bottom: 50),
                                            height: 200,
                                            //color: Color(0xFFECF2FF),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(60),
                                                  bottomLeft: Radius.circular(30)),
                                              color: Colors.black,
                                            ),
                                            child: Image.network(
                                              document['coverUrl'],
                                              //height: 150,
                                              width:350,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          Positioned(
                                            top: 90,
                                            left: 110,
                                            child: CircleAvatar(
                                              radius: 70,
                                              backgroundColor: Colors.grey[100],
                                              backgroundImage:NetworkImage(
                                                document['imageUrl'],

                                              ) ,
                                            ),
                                          ),
                                        ],
                                      ),
                                      //////////////////////name////////////////////////////////////////////////////////////////////
                                      SizedBox(
                                        height: 35,
                                      ),
                                      Text(
                                        document['shopname'],
                                        style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20,color: Colors.black),
                                      ),
                                      //////////////////address///////////////////////////////////////////////////////////////////////
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: 18,
                                          ),
                                          // color: Colors.cyan,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset("assets/icons/Location.svg"),
                                              const SizedBox(width: defaultPadding / 2),
                                              Text(document['address'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ///////////////////phone////////////////////////////////////////////////////////////////////////////
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Container(

                                          // color: Colors.cyan,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(horizontal: 2.0),
                                                child: Icon(
                                                  Icons.phone,
                                                  color: Colors.grey[400],
                                                  size: 15,
                                                ),
                                              ),
                                              const SizedBox(width: defaultPadding / 2),
                                              Text(document['phone'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      /////////////////////ABOUT////////////////////////////////////////////////////////////////////
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Container(

                                          // color: Colors.cyan,
                                          child: Row(
                                            children: [
                                              const SizedBox(width: defaultPadding / 2),
                                              Text(document['about'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      /////////////////Rating///////////////////////////////////////////////////////////
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              RatingBar(
                                                minRating: 1,
                                                maxRating: 5,
                                                initialRating: 3,
                                                allowHalfRating: true,
                                                itemSize: 20,
                                                // onRatingUpdate: _saveRating,
                                                ratingWidget: RatingWidget(
                                                    full: Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    half: Image.asset('assets/heart_half.png'),
                                                    empty: Icon(
                                                      Icons.star,
                                                      color: Colors.grey,
                                                    )),
                                                onRatingUpdate: (double value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      //////////////////Social media ////////////////////////////////////////////////////////////
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 18,
                                        ),
                                        // color: Colors.cyan,
                                        child: Row(
                                          children: [

                                            IconButton(
                                              onPressed: () {
                                                launch(document["facebook"]);
                                              },
                                              icon: Icon(
                                                Icons.facebook_rounded,
                                                color: Colors.blue[400],
                                                size: 30,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 90,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Share.share('com.bikaam.bikaam');
                                              },
                                              icon: Icon(
                                                Icons.share_outlined,
                                                color: Colors.black,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ////////////////////////Follow///////////////////////////////////////////////////////////////////////
                                      //const SizedBox(height: 2),
                                      //FollowButton(value: document["uid"],),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget> [

                                            //  BuildProfileButton(name: document['shopname'], image: document['imageUrl'], venderid:document['uid']),

                                            InkWell(
                                              onTap: () async {
                                                _auth = FirebaseAuth.instance;
                                                _user = _auth.currentUser;
                                                if (_user==null) {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));

                                                }else{
                                                  getUsersData();
                                                  FirebaseAuth auth= FirebaseAuth.instance;
                                                  String uid=auth.currentUser!.uid.toString();
                                                  Map <String,dynamic> data={"name":document["shopname"],"imageUrl":document['imageUrl'],"uid":uid,
                                                    "coverUrl":document["coverUrl"],"venderid":document["uid"],"address":document['address'],"phone":document['phone'],
                                                  };
                                                  Map <String,dynamic> userdata={"name":firstName,"uid":uid,"isSelected":false
                                                  };
                                                  final coll= FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(value);
                                                  if( ((await coll.get())!.exists)){
                                                    var altertDialog = AlertDialog(
                                                      title: Row(children: [
                                                        Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                                                      ],),
                                                      content:
                                                      Text("انت بالفعل من متابعينا"),

                                                    );
                                                    showDialog(context: context, builder: (BuildContext context)
                                                    {
                                                      return altertDialog;
                                                    });
                                                    //////////

                                                  }else{
                                                    FirebaseFirestore.instance.collection(uid).doc("followers").collection("followers").doc(document['uid']).set(data);
                                                    FirebaseFirestore.instance.collection(document['uid']).doc("followers").collection("followers").doc(uid).set(userdata);
                                                    var altertDialog = AlertDialog(
                                                      title: Row(children: [
                                                        Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                                                      ],),
                                                      content:
                                                      Text("شكرا لانضمامك لعائلتنا "),

                                                    );
                                                    showDialog(context: context, builder: (BuildContext context)
                                                    {
                                                      return altertDialog;
                                                    });
                                                  }
                                                }

                                              },
                                              child: Container(


                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 5,),
                                                    Icon(Icons.person_add_alt_1,color: Colors.white,),
                                                    SizedBox(width: 7,),
                                                    Text("متابعة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                                  ],
                                                ),


                                                color:Colors.blue ,
                                                height: 45,
                                                width:100,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            InkWell(
                                              onTap: (){
                                                _auth = FirebaseAuth.instance;
                                                _user = _auth.currentUser;
                                                if(_user==null){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                                                }
                                                else{
                                                  var altertDialog = AlertDialog(
                                                    backgroundColor: Color(0xFFECF2FF),
                                                    elevation: 20,
                                                    title: Row(children: [
                                                      Text("ارسال رسالة",style: TextStyle(color: Colors.black ,fontSize: 20,fontWeight: FontWeight.bold),),
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
                                                                child: Padding(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                  child: Container(
                                                                    height: 100,
                                                                    child: TextField(


                                                                      controller: _message,
                                                                      maxLines: null,
                                                                      keyboardType: TextInputType.multiline,
                                                                      //obscureText: true,

                                                                      decoration: InputDecoration(
                                                                        helperMaxLines: 8,
                                                                        contentPadding: EdgeInsets.only(top: 10,bottom: 20),
                                                                        border: InputBorder.none,
                                                                        hintText: 'اكتب رسالتك',
                                                                      ),
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
                                                                Map <String,dynamic> data={"message":_message.text,"uid":uid,"username":firstName};
                                                                FirebaseFirestore.instance.collection(document['uid']).doc("messages").collection("messages").add(data);
                                                                // FirebaseFirestore.instance.collection(uid).doc("orders").collection("orders").add(data);
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

                                                }

                                              },
                                              child: Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(6.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.email,color: Colors.white,),
                                                      SizedBox(width: 5,),
                                                      Text("ارسال رسالة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                    ],
                                                  ),
                                                ),
                                                color: Colors.red,
                                                height: 45,
                                                width: 120,
                                              ),
                                            ),
                                            const SizedBox(width: 25),
                                            InkWell(
                                              onTap:(){
                                                launch("whatsapp://send?phone=+2"+document['phone']);

                                              } ,

                                              //   child: IconButton(
                                              //   onPressed: () {
                                              //     launch("whatsapp://send?phone=+2"+document['phone']);
                                              //   },
                                              //   icon: Icon(
                                              //     Icons.whatsapp,
                                              //     color: Colors.green[400],
                                              //     size: 40,
                                              //   ),
                                              // ),
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.grey[100],
                                                child:Icon(
                                                  Icons.whatsapp_outlined,
                                                  color: Colors.green[600],
                                                  size: 42,
                                                ) ,

                                              ),
                                            )

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ///////////////////Banner//////////////////////////////////////////////////////////////////////////
                                      document['banner']==null? Image.network(
                                        document['banner'],
                                        width: 300,
                                        fit: BoxFit.fill,
                                      ):Container(),

                                      /////////////////////////////////////////////////////////////////////////////////////////////////////

                                      ///////////////////list category//////////////////////////////////////////////////////////////////////
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5.0),
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(2),
                                            color: Colors.white,
                                            //border: Border.all(color: Colors.black12),
                                          ),
                                          // width: 400,
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage2(cat:document['category'],value: value, )));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Container(
                                                    width: 50,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.blue,
                                                      border: Border.all(color: Colors.black12),
                                                    ),
                                                    child: Center(child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                      child: Text("الكل",style: TextStyle(color: Colors.white),),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                              ListCategory(value: value,),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // ListCategory(value:document['uid']),
                                      //////////////////////////////////////////
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Container(

                                          // color: Colors.cyan,
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllProduct(value: value)));
                                            },
                                            child: Row(
                                              children: [
                                                const SizedBox(width: defaultPadding / 2),
                                                Text(" عرض الكل ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.blue[900])),
                                                Icon(Icons.arrow_back_ios_new_sharp,size: 17,color: Colors.blue[900],),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ////////////////////List Products/////////////////////////////////////////////////////////////////////
                                      ListProducts(value:value),
                                      SizedBox(height: 10,),
                                      /////////////////////////////////////////////////////////////////////////////////////////////////////

                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          });
                    }
                ),



             //// scroll(value),

              //scroll(value),
            ]

          ),
          bottomNavigationBar: CurvedNavigationBar(
            //backgroundColor: Colors.blueAccent,
              color: Colors.blue,
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: Colors.redAccent,
              animationCurve: Curves.easeInOut,
              height: 60,
              index: index,
              animationDuration: Duration(milliseconds: 10),
              items: [
                CurvedNavigationBarItem(
                  child: Icon(Icons.perm_identity,color: Colors.white,),
                  label: 'ملف شخصي',
                  labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
                ),
                CurvedNavigationBarItem(
                  child: Icon(Icons.article_outlined,color: Colors.white,),
                  label: 'الطلبات',
                  labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
                ),
                CurvedNavigationBarItem(
                  child: Icon(Icons.home,color: Colors.white,),
                  label: 'الرئيسية',
                  labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
                ),
                CurvedNavigationBarItem(
                  child: Icon(Icons.storefront,color: Colors.white,),
                  label: 'المستعمل',
                  labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
                ),
                CurvedNavigationBarItem(
                  child: Icon(Icons.video_collection,color: Colors.white,),
                  label: 'فيدوهات',
                  labelStyle: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),
                ),
              ],
              onTap: onItemPressed),
        /*  body: Stack(
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
          ),*/

        ));*/

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

  scroll(String vendorid) {
    return DraggableScrollableSheet(
        initialChildSize: 0.2,
        maxChildSize: 1.0,
        minChildSize: 0.1,
        builder: (context, scrollController) {
          return Container(
            //height: 200,
            //color: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Color(0xFFECF2FF),
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Container(

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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        // width: 400,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (){
                                //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage2(cat:document['category'],value: value, )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  width: 50,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  child: Center(child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text("الكل",style: TextStyle(color: Colors.white),),
                                  )),
                                ),
                              ),
                            ),
                            ListCategory(value: vendorid,),
                          ],
                        ),
                      ),
                    ),
                    // ListCategory(value:document['uid']),
                    ////////////////////List Products/////////////////////////////////////////////////////////////////////
                    ListProducts(value:vendorid),
                  //  SizedBox(height: 50,),
                  ],
                ),
              ),
            ),
          );
        });
  }

  onItemPressed(
      index,
      ) async {
    switch (index) {
      case 0:
        print('go to person');
        _auth = FirebaseAuth.instance;
        _user = _auth.currentUser;
        if(_user==null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
        }
        break;
      case 1:
        if(_user==null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderShow()));
        }

        break;

      case 2:
        print('go to home');
        if(_user==null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen2()));
        }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }

        break;


      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));

        break;

      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Video()));
        print('go to settings 3');
        break;
    }
  }

}


