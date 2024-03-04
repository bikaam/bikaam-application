import 'package:bikaam/screens/home/searchpage.dart';
import 'package:bikaam/screens/show/messages.dart';
import 'package:bikaam/screens/show/notifcation.dart';
import 'package:bikaam/screens/show/ordershow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import '../screens/home/category.dart';
import '../screens/home/components/search_form.dart';
import '../screens/home/homescreen2.dart';
import '../screens/show/Video.dart';
import '../screens/usedproduct/homepage/homwpage.dart';
import 'citygetbannerbottom1.dart';
import 'citygetbannerbottom2.dart';
import 'citygetbannertop 1.dart';
import 'citygetbannertop2.dart';
import 'citygettextbanner.dart';
import 'cityproducttimer.dart';
import 'cityshowsectionproduct.dart';


const List<String> list = <String>["قنا","الاقصر"];



class NewHomeScreen2 extends StatefulWidget {
  late String value;

  NewHomeScreen2({required this.value});

  @override
  State<NewHomeScreen2> createState() => _NewHomeScreen2State(value);
}

class _NewHomeScreen2State extends State<NewHomeScreen2> {
  String value;
  _NewHomeScreen2State(this.value);
  set index(int index) {}
  late String userid;

  @override
  Widget build(BuildContext context) {
    int index = 2;
    var _selectedIndex = 0;
    int curentIndex = 0;
    String dropdownValue = list.first;

    final items = <Widget>[
      Icon(
        Icons.person,
        size: 30,
      ),
      Icon(
        Icons.home,
        size: 30,
      ),
      Icon(
        Icons.article_outlined,
        size: 30,
      ),
      Icon(
        Icons.storefront,
        size: 30,
      ),

    ];
    const _colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];
    const _colorizeTextStyle = TextStyle(
        fontSize: 15.0,
        fontFamily: 'Horizon',
        fontWeight: FontWeight.bold,
        color: Colors.white
    );

    var theme;

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
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: Image.asset(
                            "assets/images/logo.png",
                            width: 90,
                          ),
                        ),
                        // const SizedBox(width: defaultPadding),
                        //////city////////////////////////////////
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
                        /* const SizedBox(width: defaultPadding /5),
                        Container(
                          width: 50,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_drop_down),

                            elevation: 10,
                            isExpanded: true,
                            style: const TextStyle(color: Colors.black),

                            onChanged: (String? value) {
                              // This is called when the user selects an item.

                              setState(() {
                                dropdownValue = value!;
                              });
                              print(dropdownValue);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewHomeScreen2(value:dropdownValue )));

                            },
                            items: list.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(width: defaultPadding /2),*/
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
                  Center(

                      child:
                      Row(
                        children: [
                         // SizedBox(width:15),

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
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryShow(value: document['name'], city: value,)));

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
                  Center(
                   // padding: EdgeInsets.symmetric(vertical: defaultPadding),
                    child: Row(
                      children: [
                        CityGetBannerBottom1(value: value,),
                        SizedBox(
                          width: 10,
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
                      SizedBox(width: 290,),
                      Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                    ],
                  ),
                  CityProductTimer(value: value,),
                  SizedBox(height: 30,),

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
            context, MaterialPageRoute(builder: (context) => SignUpPage()));

        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));

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