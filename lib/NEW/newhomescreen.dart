
import 'package:bikaam/screens/home/searchpage.dart';
import 'package:bikaam/screens/show/messages.dart';
import 'package:bikaam/screens/show/notifcation.dart';
import 'package:bikaam/screens/show/ordershow.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../admin/pages/AdminShowpopular.dart';
import '../../constants.dart';
import '../../functions/cartnum.dart';
import '../../functions/getwallet.dart';
import '../../functions/messagenum.dart';

import '../screens/home/category.dart';
import '../screens/home/components/search_form.dart';
import '../screens/home/home_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/show/Cart.dart';
import '../screens/show/Video.dart';
import '../screens/usedproduct/homepage/homwpage.dart';
import 'citygetbannerbottom1.dart';
import 'citygetbannerbottom2.dart';
import 'citygetbannertop 1.dart';
import 'citygetbannertop2.dart';
import 'citygettextbanner.dart';
import 'cityproducttimer.dart';
import 'cityshowsectionproduct.dart';
String notify="0";
String message="0";
String cart="0";
const List<String> list = <String>["قنا","الاقصر"];

class NewHomeScreen extends StatefulWidget {
  late String value;

  NewHomeScreen({required this.value});
  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState(value);
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  String value;
  _NewHomeScreenState(this.value);
  set index(int index) {}
  late String userid;
  bool city=false;
  late String cityvalue;

  @override
  Widget build(BuildContext context) {
    int index = 2;
    String dropdownValue = value;
    cityvalue=value;

    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    TextEditingController _text=TextEditingController();
    CollectionReference ref = FirebaseFirestore.instance.collection(uid);


    userid = uid;
    return Scaffold(
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
                    // color: Colors.grey[100],
                    child: Column(
                        children: [

                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 95,
                                  //color: Colors.blue,
                                  child: ListView(

                                    children: snapshot.data!.docs.map((document) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 0),
                                        child: Container(
                                          width: 350,


                                          decoration: BoxDecoration(
                                              color: Colors.white
                                            // border: Border.all(color: Colors.black12)
                                          ),
                                          child: Row(

                                            children: [
                                              SizedBox(width: 5,),
                                              Stack(
                                                children: [
                                                  Positioned(
                                                    child: IconButton(
                                                      icon: SvgPicture.asset("assets/icons/Notification.svg",),
                                                      onPressed: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowNotify()));
                                                      },
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 5,
                                                    // left:7,
                                                    right: 5,
                                                    child: CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor: Colors.red,
                                                      child: Text(document["notifynum"],style: TextStyle(fontSize: 8),),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: 3,),

                                              Stack(
                                                children: [
                                                  Positioned(
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => ShowMessages()));
                                                      },
                                                      icon: Icon(
                                                        Icons.email_outlined,
                                                        color: Colors.grey[400],
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 5,
                                                    // left:7,
                                                    right: 5,
                                                    child: CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor: Colors.red,
                                                      child: Text(document["messages"],style: TextStyle(fontSize: 8),),
                                                    ),
                                                  )

                                                ],
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                child: Image.asset(
                                                  "assets/images/logo.png",
                                                  width: 100,
                                                ),
                                              ),
                                              // const SizedBox(width: defaultPadding),
                                              // SvgPicture.asset("assets/icons/Location.svg"),
                                              // const SizedBox(width: defaultPadding /5),
                                              SvgPicture.asset("assets/icons/Location.svg"),
                                              Text(value),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(8),
                                                    //border: Border.all(color: Colors.black12),

                                                  ),
                                                  child: StreamBuilder(
                                                      stream:FirebaseFirestore.instance.collection("admin").doc("city").collection("City").snapshots(),
                                                      builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot) {
                                                        List<DropdownMenuItem> catItems=[];
                                                        if (!snapshot.hasData) {
                                                          return Text('', style: TextStyle(color: Colors.black),);
                                                        }
                                                        else{
                                                          final category=snapshot.data?.docs.reversed.toList();
                                                          for(var cat in category!){
                                                            catItems.add(
                                                              DropdownMenuItem(
                                                                value: cat['city'],
                                                                child: Text(cat['city']),
                                                              ),
                                                            );
                                                          }
                                                        }
                                                        return DropdownButton<dynamic>( items: catItems, onChanged: (catvalue){
                                                          //print(catvalue);
                                                          setState(() {
                                                            cate=catvalue;
                                                            print(cate);
                                                            if(cate=="قنا"){
                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));

                                                            }
                                                            else{Navigator.push(context, MaterialPageRoute(builder: (context) => NewHomeScreen(value: cate)));}


                                                          });

                                                        },
                                                          //value: cate,
                                                          icon: const Icon(Icons.arrow_drop_down),
                                                          // elevation: 16,
                                                          isExpanded: true,
                                                          // dropdownColor: Colors.white
                                                          style: const TextStyle(color: Colors.black),

                                                          // isExpanded: false,
                                                          // isExpanded: false,
                                                        );


                                                      }


                                                  ),
                                                ),
                                              ),


                                              Stack(
                                                children: [
                                                  Positioned(
                                                    child: IconButton(
                                                      onPressed: () {

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => Cart()));                          },
                                                      icon: Icon(
                                                        Icons.shopping_cart_outlined,
                                                        color: Colors.grey[400],
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 5,
                                                    // left:7,
                                                    right: 5,
                                                    child: CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor: Colors.red,
                                                      child: Text(document["cartnum"],style: TextStyle(fontSize: 8),),
                                                    ),
                                                  )
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),

                                      );

                                    }).toList(),

                                  ),
                                ),
                              ),
                            ],
                          ),

                          Container(
                            height: 600,
                            child: ListView(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 15,),
                                      IconButton(
                                        onPressed: () async {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => Profile()));
                                        },
                                        icon: Icon(
                                          Icons.menu,
                                          color: Colors.grey[400],
                                          size: 30,
                                        ),
                                      ),
                                      Container(
                                        height: 35,
                                        width: 210,
                                        // color: Colors.,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(30),
                                            border: Border.all(color: Colors.black12)),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Icon(
                                                Icons.search_rounded,
                                                color: Colors.grey[400],
                                                size: 30,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => SearchPage()));
                                              },
                                              child: Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "search",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.grey[800]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // SizedBox(width: 50,),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.wallet,
                                        color: Colors.grey[400],
                                        size: 25,
                                      ),
                                      GetWallet(),

                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),


                                  ///////////textbanner/////////////////////////////
                                  /*GetBannerTop1(),*/
                                  SizedBox(
                                    height: 5,
                                  ),

                                  CityGetTextBanner(value: value,),
////////////////////////////////slide banner////////////////////////////////////////////////////////////////
                                  SearchForm(),
///////////////////////////////top banner/////////////////////////////////////////////////////////////////////////
                                  Container(

                                      child:
                                      Row(
                                        children: [
                                          SizedBox(width:15),

                                          CityGetBannerTop1(value: value,),
                                          SizedBox(width:10),
                                          CityGetBannerTop2(value: value,),

                                        ],
                                      )
                                  ),
////////////////////////////////////////Stores/////////////////////////////////////////////////////


                                  SizedBox(height: 20,),


                                  Center(
                                    child: Row(
                                      children: [
                                        SizedBox(width: 20,),
                                        Container(
                                          height: 2,
                                          width: 100,
                                          // color: Colors.,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: Colors.black12,)

                                          ),
                                        ),
                                        SizedBox(width: 15,),


                                        Center(
                                          child: Text(
                                            "افضل المتاجر",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 17),


                                          ),
                                        ),
                                        SizedBox(width: 15,),
                                        Container(
                                          height: 2,
                                          width: 100,
                                          // color: Colors.,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: Colors.black12,)

                                          ),
                                        ),

                                      ],
                                    ),
                                  ),


                                  SizedBox(height: 5,),

                                  Container(
                                    //height: 40,
                                    width: 310,
                                    //height: 300,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      //border: Border.all(color: Colors.black12),
                                    ),
                                    child:  Container(

                                      height: 300,
                                      child:
                                      StreamBuilder(
                                          stream:FirebaseFirestore.instance.collection(value).doc("stores").collection("Stores").snapshots(),
                                          builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Text('no values', style: TextStyle(color: Colors.black),);
                                            }
                                            return GestureDetector(
                                              //onTap: goToCat,
                                              child: Container(
                                                // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                child: GridView(
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 5,
                                                    mainAxisSpacing: 5,
                                                    mainAxisExtent: 170,
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  children: snapshot.data!.docs.map((document) {
                                                    return
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryShow(value: document['name'], city:value,)));

                                                        },
                                                        child: Container(
                                                          height:200,
                                                          width: 150,
                                                          //color: Colors.black,
                                                          child: Stack(
                                                            clipBehavior: Clip.none,
                                                            //fit: StackFit.expand,
                                                            children: [
                                                              Container(
                                                                height: 120,
                                                                child:

                                                                CircleAvatar(
                                                                  radius: 100,
                                                                  backgroundImage:NetworkImage(
                                                                    document['image'],
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 130,
                                                                left: 15,
                                                                child: Container(
                                                                  width: 120,

                                                                  color: Colors.grey[100],
                                                                  child: Center(
                                                                    child: GestureDetector(
                                                                      //onTap: OpenSignup,
                                                                        child: Text(
                                                                          document['name'],
                                                                          style: TextStyle(
                                                                              color: Colors.blue[900],
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
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
                                    ),
                                  ),

                                  SizedBox(height: 20,),
//////////////////////////////////////bottom banner////////////////////////////////////////////////////////////////////////
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: defaultPadding),
                                    child: Row(
                                      children: [
                                        CityGetBannerBottom1(value: value,),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        CityGetBannerBottom2(value: value,),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15,),
/////////////////////////////sections////////////////////////////////////////////////////////////////////////
                                  Container(
                                    //height: 40,
                                    width: 310,
                                    //height: 300,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      //border: Border.all(color: Colors.black12),
                                    ),
                                    child:  Container(

                                      height: 300,
                                      child:
                                      StreamBuilder(
                                          stream:FirebaseFirestore.instance.collection(value).doc("sections").collection("Sections").snapshots(),
                                          builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Text('no values', style: TextStyle(color: Colors.black),);
                                            }
                                            return GestureDetector(
                                              //onTap: goToCat,
                                              child: Container(
                                                // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                child: ListView(

                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  children: snapshot.data!.docs.map((document) {
                                                    return
                                                      InkWell(
                                                        onTap: (){
                                                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryShow(value: document['name'])));

                                                        },
                                                        child: Column(
                                                          children: [
                                                            Center(
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(width: 20,),
                                                                  Container(
                                                                    height: 2,
                                                                    width: 100,
                                                                    // color: Colors.,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        border: Border.all(color: Colors.black12,)

                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 15,),


                                                                  Center(
                                                                    child: Text(
                                                                      document['section'],
                                                                      style: Theme.of(context)
                                                                          .textTheme
                                                                          .headline5!
                                                                          .copyWith(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 17),


                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 15,),
                                                                  Container(
                                                                    height: 2,
                                                                    width: 100,
                                                                    // color: Colors.,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        border: Border.all(color: Colors.black12,)

                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                            CitySectionProduct(value: value, section: document['section'],),

                                                          ],
                                                        ),
                                                      );

                                                  }
                                                  ).toList(),
                                                ),
                                              ),
                                            );
                                          }


                                      ),
                                    ),
                                  ),


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////عروض/////////////////////////////////////////////////////////////////عروض/////////////////////////////

                                  Center(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 2,
                                          width: 120,
                                          // color: Colors.,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: Colors.black12,)

                                          ),
                                        ),
                                        SizedBox(width: 15,),


                                        Center(
                                          child: Text(
                                            "عروض",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 17),


                                          ),
                                        ),
                                        SizedBox(width: 15,),
                                        Container(
                                          height: 2,
                                          width: 120,
                                          // color: Colors.,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: Colors.black12,)

                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 320,),
                                      Icon(
                                        Icons.arrow_back_ios_new_sharp,
                                        color: Colors.grey[400],
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                  CityProductTimer(value: value,),
                                  SizedBox(height: 30,),
/////////////////////////////////////////////////////////////////////////////////////////////////////
                                ]),
                          ),])));
          }),

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
  }

  onItemPressed(
      index,
      ) async {
    switch (index) {
      case 0:
        print('go to person');

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profile()));

        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderShow()));

        break;

      case 2:
        print('go to home');
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));

        break;

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

//void setState(Null Function() param0) {}
}