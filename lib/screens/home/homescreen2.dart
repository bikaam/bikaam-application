import 'package:bikaam/screens/home/searchpage.dart';
import 'package:bikaam/screens/show/messages.dart';
import 'package:bikaam/screens/show/notifcation.dart';
import 'package:bikaam/screens/show/ordershow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../NEW/cityshowsectionproduct.dart';
import '../../NEW/newhomescreen2.dart';
import '../../SignScreen.dart';
import '../../admin/pages/AdminShowpopular.dart';
import '../../constants.dart';
import '../../functions/getbannerbottom2.dart';
import '../../functions/getbannerbotttom1.dart';
import '../../functions/getbannertop 1.dart';
import '../../functions/getbannertop2.dart';
import '../../functions/gettextbanner.dart';

import '../../functions/producttimer.dart';
import '../loginscreen.dart';


import '../show/Video.dart';
import '../usedproduct/homepage/homwpage.dart';
import 'category.dart';

import 'components/search_form.dart';
import 'home_screen.dart';
const List<String> list = <String>["قنا","الاقصر"];

String cate="قنا";


class HomeScreen2 extends StatefulWidget {
  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {

  set index(int index) {}
  late String userid;

  @override
  Widget build(BuildContext context) {
    int index = 2;

    return Scaffold(
      body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /////////notyfiy////////
                        Stack(
                          children: [
                            IconButton(
                              icon: SvgPicture.asset("assets/icons/Notification.svg"),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));

                              },
                            ),
                            //NotifyNum(),
                          ],
                        ),
                        ///////email/////////////////////
                        Stack(
                          children: [
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                                },
                                icon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey[400],
                                  size: 30,
                                ),
                              ),
                            ),
                            //MessageNum(),
                          ],
                        ),
                        /////////logo//////////////////
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.asset(
                            "assets/images/logo.png",
                            width: 90,
                          ),
                        ),
                        // const SizedBox(width: defaultPadding),
                        //////city////////////////////////////////
                        SvgPicture.asset("assets/icons/Location.svg"),
                        Text("قنا"),
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen2()));

                                      }
                                      else{Navigator.push(context, MaterialPageRoute(builder: (context) => NewHomeScreen2(value: cate)));}


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

                        ////cart//////////////////////////////////
                        Stack(
                          children: [
                            IconButton(
                              onPressed: () {

                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                              },
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.grey[400],
                                size: 30,
                              ),
                            ),
                            // CartNum(),
                          ],
                        ),

                      ],
                    ),
                  ),
//////////////////////////////////////////////////////////////

                  Row(
                    children: [

                      IconButton(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                        },
                        icon: Icon(
                          Icons.menu,
                          color: Colors.grey[400],
                          size: 25,
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 200,
                        // color: Colors.,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.black12)

                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Icon(
                                Icons.search_rounded,
                                color: Colors.grey[400],
                                size: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
                              },
                              child: Container(

                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text("ابحث",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.grey[600]),),
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
                      Text("0.0 EGP",style: TextStyle(fontSize: 12),),


                    ],
                  ),
                  SizedBox(height: 5,),
                  GetTextBanner(),

                  SearchForm(),

                  ////////////////////////////////////////


                  Center(

                      child:
                      Row(
                        children: [
                         // SizedBox(width:10),

                          GetBannerTop1(),
                          SizedBox(width:10),
                          GetBannerTop2(),

                        ],
                      )
                  ),
                  ////////////////////////////////////////////////
                  SizedBox(height: 20,),
                  Center(
                    child: Row(
                      children: [
                        //SizedBox(width: 20,),
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

                      height: 350,
                      child:
                      StreamBuilder(
                          stream:FirebaseFirestore.instance.collection("admin").doc("stores").collection("Stores").snapshots(),
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryShow(value: document['name'], city: "admin",)));

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


                  /*      Container(

                                child: Column(
                                  children: [
                                    Center(
                                      child: Row(
                                        children: [
                                          SizedBox(width: 25,),
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryShow(value: "Women")));

                                            },
                                            child: Container(
                                              height:120,
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
                                                      backgroundImage: AssetImage("assets/images/fashio.jpg",),
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
                                                              " متاجر ملابس حريمى ",
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
                                          ),
                                          SizedBox(width: 10,),
                                          InkWell(
                                            onTap:(){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryShow(value: "Men")));

                                            },
                                            child: Container(
                                              height:120,
                                              width:150,
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                //fit: StackFit.expand,
                                                children: [
                                                  Container(
                                                    // margin: const EdgeInsets.only(bottom: 50),
                                                    height: 120,
                                                    child:
                                                    CircleAvatar(
                                                      radius: 100,
                                                      backgroundImage: AssetImage("assets/images/fashion2.jpg",),
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
                                                              "متاجر ملابس رجالى",
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
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height:50),
                                    Center(
                                      child: Row(
                                        children: [
                                          SizedBox(width: 25,),
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryShow(value: "Kids")));

                                            },
                                            child: Container(
                                              height:120,
                                              width: 150,
                                              // color: Colors.black,
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                //fit: StackFit.expand,
                                                children: [
                                                  Container(
                                                    // margin: const EdgeInsets.only(bottom: 50),
                                                    height: 120,
                                                    child:
                                                    CircleAvatar(
                                                      radius: 100,
                                                      backgroundImage: AssetImage("assets/images/fachild.jpg",),
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
                                                              " متاجر ملابس اطفالى ",
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
                                          ),
                                          SizedBox(width: 10,),
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryShow(value: "Others")));

                                            },
                                            child: Container(
                                              height:120,
                                              width:150,
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                //fit: StackFit.expand,
                                                children: [
                                                  Container(
                                                    // margin: const EdgeInsets.only(bottom: 50),
                                                    height: 120,

                                                    child:
                                                    CircleAvatar(
                                                      radius: 100,
                                                      backgroundImage: AssetImage("assets/images/acs2.jpg",),
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
                                                              "متاجر متنوع ",
                                                              style: TextStyle(
                                                                  color: Colors.blue[900],
                                                                  fontSize: 17,
                                                                  fontWeight: FontWeight.bold),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),*/
                  SizedBox(height: 20,),
                  ////////////////////////////////////////

                  SizedBox(height: 20,),
                  Center(
                   //adding: EdgeInsets.symmetric(vertical: defaultPadding),
                    child: Row(
                      children: [
                        GetBannerBottom1(),
                        SizedBox(
                          width: 10
                        ),
                        GetBannerBottom2(),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
////////////////////////////////////////////////
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
                          stream:FirebaseFirestore.instance.collection("admin").doc("sections").collection("Sections").snapshots(),
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
                                                  //SizedBox(width: 20,),
                                                  Container(
                                                    height: 2,
                                                    width: 90,
                                                    // color: Colors.,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Colors.black12,)

                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),


                                                  Center(
                                                    child: Text(
                                                      document['section'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 17),


                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Container(
                                                    height: 2,
                                                    width: 90,
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
                                            CitySectionProduct(value: "admin", section: document['section'],),

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
                  ////// //////////////////////////////////////////
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
                      SizedBox(width: 300,),
                      Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.grey[400],
                        size: 15,
                      ),
                    ],
                  ),
                  ProductTimer(),
                  SizedBox(height: 30,),
                  /*    const NewArrivalProducts(),*/
                  // const PopularProducts(),
                ],
              ),
            );
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
  }

  onItemPressed(
      index,
      ) async {
    switch (index) {
      case 0:
        print('go to person');

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));

        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));

        break;

      case 2:
        print('go to home');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen2()));

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

}
