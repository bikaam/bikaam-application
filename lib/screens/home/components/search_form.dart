import 'package:bikaam/screens/home/components/product_card2.dart';
import 'package:bikaam/screens/home/components/section_title.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';
import '../../details/details_screen.dart';


const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);

class SearchForm extends StatelessWidget {

  const SearchForm({
    Key? key,
  }) : super(key: key);

  @override
  static const List<String> imagesList=[
    "assets/images/fashion.jpg",
    "assets/images/new2.jpg",
    "assets/images/fachd2.jpg",
  ];
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Column(
            children:[
             // SizedBox(height: 10),
              CarouselSlider(items: imagesList.map((e) => ClipRect(
               // borderRadius: BorderRadius.circular(10),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      e,
                      height: 350,
                      width: 100,
                      fit: BoxFit.cover,
                    ),

                  ],
                ),

              )).toList() , options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,

                height: 150,


              ),)


            ],
          )
        ),

      ],
    );
  }
}
/*import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageSliderFirebase extends StatefulWidget {
  const ImageSliderFirebase({super.key});

  @override
  State<ImageSliderFirebase> createState() => _ImageSliderFirebaseState();
}

class _ImageSliderFirebaseState extends State<ImageSliderFirebase> {
  late Stream<QuerySnapshot> imageStream;
  int currentSlideIndex = 0;
  CarouselController carouselController = CarouselController();
  @override
  void initState() {
    super.initState();
    var firebase = FirebaseFirestore.instance;
    imageStream = firebase.collection("admin").doc("banner").collection("SlideBanner").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 300,
      child:
      StreamBuilder<QuerySnapshot>(
        stream: imageStream,
        builder: (_, snapshot) {
          if (snapshot.hasData ) {
            return Container(
              child: CarouselSlider.builder(
                  carouselController: carouselController,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index, ___) {
                    DocumentSnapshot sliderImage =
                    snapshot.data!.docs[index];
                    return Image.network(
                      sliderImage['banner'],
                      fit: BoxFit.contain,
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, _) {
                      setState(() {
                        currentSlideIndex = index;
                      });
                    },
                  )),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
   /* return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: imageStream,
              builder: (_, snapshot) {
                if (snapshot.hasData && snapshot.data!.docs.length > 1) {
                  return CarouselSlider.builder(
                      carouselController: carouselController,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index, ___) {
                        DocumentSnapshot sliderImage =
                        snapshot.data!.docs[index];
                        return Image.network(
                          sliderImage['banner'],
                          fit: BoxFit.contain,
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, _) {
                          setState(() {
                            currentSlideIndex = index;
                          });
                        },
                      ));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            ' Current Slide Index $currentSlideIndex',
            style: const TextStyle(fontSize: 20),
          )
        ],
      ),
    );*/
  }
}*/
