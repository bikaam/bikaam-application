import 'package:bikaam/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class ThansPage extends StatefulWidget {
  const ThansPage({Key? key}) : super(key: key);

  @override
  State<ThansPage> createState() => _ThansPageState();
}

class _ThansPageState extends State<ThansPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text("الفاتورة",style: TextStyle(color: Colors.white),)),
          elevation:5,
          backgroundColor: Colors.blue[900],

          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),

          ]
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.blue[900],
                    size: 25,
                  ),
                  SizedBox(width: 15,),
                  Icon(
                    Icons.circle,
                    color: Colors.blue[900],
                    size: 10,
                  ),
                  SizedBox(width: 15,),
                  Icon(
                    Icons.circle,
                    color: Colors.blue[900],
                    size: 10,
                  ),
                  SizedBox(width: 15,),
                  Icon(
                    Icons.circle,
                    color: Colors.blue[900],
                    size: 10,
                  ),
                  SizedBox(width: 15,),
                  Icon(
                    Icons.circle,
                    color: Colors.blue[900],
                    size: 10,
                  ),
                  SizedBox(width: 15,),
                  Icon(
                    Icons.featured_play_list_outlined,
                    color: Colors.blue[900],
                    size: 25,
                  ),
                  SizedBox(width: 15,),
                  Icon(
                    Icons.circle,
                    color: Colors.blue[900],
                    size: 10,
                  ),
                  SizedBox(width: 15,),
                  Icon(
                    Icons.circle,
                    color: Colors.blue[900],
                    size: 10,
                  ),
                  SizedBox(width: 15,),
                  Icon(
                    Icons.circle,
                    color: Colors.blue[900],
                    size: 10,
                  ),
                  SizedBox(width: 15,),
                  Icon(
                    Icons.circle,
                    color: Colors.blue[900],
                    size: 10,
                  ),
                  SizedBox(width: 15,),
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.blue[900],
                    size: 25,
                  ),
                  SizedBox(width: 15,),
                ],
              ),
            ),
            SizedBox(height: 30,),

            Center(child: Image.asset('assets/images/logo.png',height: 200,)),
            Center(
              child: Text("مبروك ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue[900]),),
            ),
            Center(
              child: Text("تمت عملية الشراء بنجاح ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey[800]),),
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: ()  {

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

                },
                child: Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.red[900],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0, // soften the shadow
                        spreadRadius: 1.0, //extend the shadow
                        offset: Offset(
                          1.0, // Move to right 5  horizontally
                          1.0, // Move to bottom 5 Vertically
                        ),
                      )
                    ],
                  ),
                  child:
                  Center(child: Text("تابع التسوق",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
