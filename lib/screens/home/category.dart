import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/home/venderpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../SignScreen.dart';
import '../../constants.dart';
import '../profile/profile_screen.dart';
import '../show/Cart.dart';
import '../show/Video.dart';
import '../show/messages.dart';
import '../show/notifcation.dart';
import '../show/ordershow.dart';
import '../usedproduct/homepage/homwpage.dart';
import 'homescreen2.dart';

String vist = 'loading...';

class CategoryShow extends StatefulWidget {
  late String value,city;
  CategoryShow({required this.value,required this.city});
  print(value) {
    // TODO: implement print
    throw UnimplementedError();
  }
  //const Category({Key? key}) : super(key: key);

  @override
  State<CategoryShow> createState() => _CategoryShowState(value,city);
  //_Items2State createState() => _Items2State(value,coll);
}

class _CategoryShowState extends State<CategoryShow> {
  String value,city;
  late String userid;
  set index(int index) {}

  _CategoryShowState(this.value,this.city);
  late String image;

  @override

  int sum=0;

  void getUsersData(value) {
    FirebaseAuth auth= FirebaseAuth.instance;
     String uid=auth.currentUser!.uid.toString();
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection(value);
    usersCollection.doc(value).get().then((value) {
      var fields = (value.data() as Map<String,dynamic>);
      setState(() {
        vist = fields["views"] ;
        print("vist");
        print(vist);
      });
    });
    sum=int.parse(vist)+1;
    print("sum");
    print(sum);
    usersCollection
        .doc(value) // <-- Doc ID where data should be updated.
        .update(
        {
          'views':sum.toString(),
        });
  }

  void getUsersData1() {
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

    CollectionReference ref = FirebaseFirestore.instance.collection(city).doc("stores").collection("Stores").doc(value).collection(value);
    //int curentIndex=0;
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.grey,
        title:  Row(
          children: [

               Container(
                height: 85,
                //color: Colors.blue,
                child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 0),
                      child: Container(



                        decoration: BoxDecoration(
                            color: Colors.white
                          // border: Border.all(color: Colors.black12)
                        ),
                        child: Row(

                          children: [
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

                              ],
                            ),

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
                                      size: 25,
                                    ),
                                  ),
                                ),


                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Image.asset(
                                "assets/images/logo.png",
                                width: 110,
                              ),
                            ),
                            // const SizedBox(width: defaultPadding),
                            SvgPicture.asset("assets/icons/Location.svg"),
                           // const SizedBox(width: defaultPadding /4),
                            city=="admin"?Text("قنا",style: Theme.of(context).textTheme.bodyText1,):Text(city,style: Theme.of(context).textTheme.bodyText1,),

                            const SizedBox(width: defaultPadding /3),
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

                              ],
                            ),

                          ],
                        ),
                      ),

                    )



                ),
              ]),



      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text(
                'لا يوجد بيانات',
                style: TextStyle(color: Colors.orange),
              );
            }

            return Scaffold(
              backgroundColor: Colors.grey[100],
              body: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    mainAxisExtent: 250,
                  ),
                  children: snapshot.data!.docs.map((document) {
                    return InkWell(
                       onTap: (){
                         //getUsersData(document['uid']);


                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => ProfilePage1(value: document['uid'],)));
                       },
                      child: SizedBox(
                        height: 800,
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                //fit: StackFit.expand,
                                children: [
                                  Container(
                                    // margin: const EdgeInsets.only(bottom: 50),
                                    height: 120,
                                    width: 170,
                                    //color: Color(0xFFECF2FF),
                                    decoration: BoxDecoration(

                                      color: Colors.black,
                                    ),
                                    child: Image.network(
                                      document['coverUrl'],
                                      //height: 150,
                                    //  width:350,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 75,
                                    left: 45,
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey[100],
                                      backgroundImage:NetworkImage(
                                        document['imageUrl'],
                                        //fit: BoxFit.cover,

                                      ) ,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 37,),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  document['shopname'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            FlatButton(
                                onPressed: () async {
    //getUsersData1();
    FirebaseAuth auth= FirebaseAuth.instance;
    //String uid=auth.currentUser!.uid.toString();
    Map <String,dynamic> data={"name":document["shopname"],"imageUrl":document['imageUrl'],"uid":"uid",
    "coverUrl":document["coverUrl"],"venderid":document["uid"],"address":document['address'],"phone":document['phone'],
    };
    Map <String,dynamic> userdata={"name":firstName,"uid":"uid","isSelected":false
    };
    final coll= FirebaseFirestore.instance.collection("uid").doc("followers").collection("followers").doc(value);
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
                                  // print(document["uid"]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfilePage1(value: document['uid'], )));

                                };},
                                child: Text(
                                  "متابعة",
                                  style: TextStyle(color: Colors.black),
                                ),
                                color: Color(0xFFECF2FF),
                              ),


                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
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

        _auth = FirebaseAuth.instance;
        _user = _auth.currentUser;
        if(_user==null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
        }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
        }
        break;
      case 1:
        if(_user==null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
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
