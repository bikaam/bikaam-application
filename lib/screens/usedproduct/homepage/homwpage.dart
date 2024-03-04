
import 'package:bikaam/screens/auth1.dart';
import 'package:bikaam/screens/home/mainpage.dart';
import 'package:bikaam/screens/usedproduct/homepage/categorypage.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import '../../../admin/pages/adminListProdutcs.dart';
import '../../../auth2.dart';
import '../../home/components/popular_products.dart';
import '../../home/home_screen.dart';
import '../../home/homescreen2.dart';
import '../../profile/profile_screen.dart';
import '../../show/Video.dart';
import '../../show/ordershow.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  set index(int index) {}
  late String userid;

  @override
  Widget build(BuildContext context) {
    int index = 3;
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

    return Scaffold(
      body: ListView(
        children: [
          AppBar(
            backgroundColor: Colors.grey[200],
            title: Text("مستعمل",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
            shadowColor: Colors.blue,
            elevation: 10,
          ),
          SizedBox(height: 30,),
          Container(
            child:Image.asset("assets/images/new.jpg",
              fit: BoxFit.cover,
              height: 100,
              width: 350,

            ) ,
          ),

          SizedBox(height: 20,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                 // height: ,
                  child: Text("التصنيفات",style: TextStyle(color: Colors.blue[900],fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120,
              color: Colors.grey[100],
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => CategoryPage(value: "clothes")));
                      },
                      child: Container(
                        height: 50,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Image.asset("assets/images/clothes.png",
                              fit: BoxFit.fill,
                                height: 40,

                              ),
                            ),
                            SizedBox(height:5,),
                            Text("ملابس",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => CategoryPage(value: "electronic")));
                      },
                      child: Container(
                        height: 50,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Image.asset("assets/images/responsive.png",
                                fit: BoxFit.fill,
                                height: 40,
                              ),
                            ),
                            SizedBox(height:5,),
                            Text("الكترونيات",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => CategoryPage(value: "pets")));
                      },
                      child: Container(
                        height: 50,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Image.asset("assets/images/pets.png",
                                fit: BoxFit.fill,
                                height: 40,
                              ),
                            ),
                            SizedBox(height:5,),
                            Text("حيوانات اليفة",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => CategoryPage(value: "other")));
                      },
                      child: Container(
                        height: 50,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Image.asset("assets/images/other.png",
                                fit: BoxFit.fill,
                                height: 40,
                              ),
                            ),
                            SizedBox(height:5,),
                            Text("متنوع",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "افضل المنتجات",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          AdminShowListProduct(),
          Container(

          )
        ],
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
            context, MaterialPageRoute(builder: (context) => Auth2()));

        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Auth1()));

        break;

      case 2:
        print('go to home');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));

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

