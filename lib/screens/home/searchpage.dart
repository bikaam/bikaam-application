import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../functions/discountshow.dart';
import '../../functions/pricedetails.dart';
import '../show/productdetail.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String name='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),
         // color: Colors.grey[100],
          child: TextField(
            decoration: InputDecoration(
             // border: Border.all(color: Colors.black),
              prefixIcon: Icon(Icons.search),hintText: 'search...'
            ),
            onChanged: (val){
              setState((){
                name=val;
              });
            },
          ),
        ),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: (name!=""&& name !=null)
            ? FirebaseFirestore.instance.collection('kKk5Vr4LOhYC4oKW2udtIvqB2Si1').doc('products').collection("products")
            .where("name",isEqualTo: name).snapshots():FirebaseFirestore.instance.collection('kKk5Vr4LOhYC4oKW2udtIvqB2Si1').doc('products').collection("products").snapshots(),
        builder: (context ,snapshot){
          return(snapshot.connectionState==ConnectionState.waiting)
              ?Center(child: CircularProgressIndicator())
              :GridView(
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
                        builder: (BuildContext context)=>ProductItemScreen(name:document['name'],price: document['price'],
                          discount:document['discount'],about:document['about'],after:document['after'].toString(),
                          image:document['imageUrl'],venderid:document['uid'],category:document['category'],Colorss: document['Colors'],
                          Sizes: document['Sizes'], shopname: document['shopname'], cashback: document['cashback'],

                        ))
                    );
                  },
                  child: Container(
                    height: double.infinity,
                    width: 154,
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
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
                                height: 170,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),

                            ShowDiscount(value: document['discount'],),
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
                        PriceDetails(price: document['price'],discount: document['discount'],after: document['after'].toString(),cashback:document['cashback'])

                      ],
                    ),
                  ),
                );



            }).toList(),


          );
        },
      ),
    );
  }
}
