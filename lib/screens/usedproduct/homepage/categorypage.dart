import 'package:bikaam/screens/home/components/addproducts.dart';
import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/home/venderpage.dart';
import 'package:bikaam/screens/usedproduct/homepage/showproductdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../functions/discountshow.dart';
import '../../../functions/pricedetails.dart';
import '../../show/productdetail.dart';
class CategoryPage extends StatefulWidget {
  late String value;
  CategoryPage({required this.value});

  @override
  State<CategoryPage> createState() => _CategoryPageState(value);
}

class _CategoryPageState extends State<CategoryPage> {
  String value;
  _CategoryPageState(this.value);
  late String image;

  @override

  int sum=0;

  Widget build(BuildContext context) {
    int index = 1;
    var _selectedIndex = 0;
    int curentIndex = 0;

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
        Icons.shopping_cart,
        size: 30,
      ),
    ];
    GoToAccount(doc) {
      print(doc);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage1(value: doc,)));
    }
    int sum=0;


    var total = 0;

    CollectionReference ref = FirebaseFirestore.instance.collection(value);
    //int curentIndex=0;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        //backgroundColor: Colors.grey,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(width: defaultPadding / 2),
            SvgPicture.asset("assets/icons/Location.svg"),
            const SizedBox(width: defaultPadding / 2),
            Text(
              "Qena",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(width: defaultPadding / 2),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(
                "assets/images/logo.png",
                width: 90,
              ),
            ),
          ],
        ),

        actions: [

          IconButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => AddUsedProducts()));

            },
            icon: Icon(
              Icons.add_box,
              color: Colors.grey[400],
              size: 30,
            ),
          ),
        ],
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

            return GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent:250,
              ),
              children: snapshot.data!.docs.map((document) {
                return
                  GestureDetector(
                    onTap:(){
                      print(document["Colors"]);

                     Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context)=>ShowUsedDetails(name:document['name'],price: document['price'],
                           about:document['about'],
                            image:document['imageUrl'],venderid:document['uid'],category:document['category'],Colorss: document['Colors'],
                            Sizes: document['Sizes'], vendorname: document['sellername'], phone: document['phone'],address: document['address'],

                          ))
                      );
                    },
                    child: Container(
                      height: double.infinity,
                      width: 154,
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2,vertical: 5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(
                            defaultBorderRadius)),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(defaultBorderRadius)),
                                ),
                                child: Image.network(document['imageUrl'],
                                  height: 180,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),

                             // ShowDiscount(value: document['discount'],),
                              //FavButton(value:document['name'])


                            ],
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  document['name'],
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              const SizedBox(width: defaultPadding / 4),

                              /* Text(
                                  document["discount"],
                                  style: const TextStyle(color: Colors.red),
                                ), */


                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                document['price']+" EGP",
                                style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 15),
                              ),
                            ],
                          ),
                        //  PriceDetails(price: document['price'],discount: document['discount'],after: document['after'].toString(),cashback:document['cashback'])

                        ],
                      ),
                    ),
                  );



              }).toList(),


            );
          }),
  /*    bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          color: Colors.blue,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.redAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 10),
          items: items,
          height: 50,
          index: index,
          onTap: onItemPressed,

          //   onTap: (index) => ,
        ),
      ), */
    );
  }

}

