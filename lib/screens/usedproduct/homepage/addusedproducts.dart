import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
class AddUsedProducts extends StatefulWidget {
  const AddUsedProducts({Key? key}) : super(key: key);

  @override
  State<AddUsedProducts> createState() => _AddUsedProductsState();
}

class _AddUsedProductsState extends State<AddUsedProducts> {
  File? image;
  late String urlimage;
  Future Pickerimage()async{
    try{
      final image= await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null) return;
      final fileimage= File(image.path);
      setState(() {
        this.image=fileimage;
      });
    }on PlatformException catch(e){
      print("failed to pick image: $e");
    }
  }

  TextEditingController _NameController= TextEditingController();
  TextEditingController _priceController= TextEditingController();
  TextEditingController _discountController= TextEditingController();
  TextEditingController _categoryController= TextEditingController();
  TextEditingController  _aboutController= TextEditingController();


  Saveproduct() async {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    var StorageImage= FirebaseStorage.instance.ref().child(image!.path);
    var task=StorageImage.putFile(image!);
    final snapshot = await task.whenComplete(() {});
    urlimage = await snapshot.ref.getDownloadURL();
    //print(uid);

    Map <String,dynamic> data={"name":_NameController.text,"price":_priceController.text,"discount":_discountController.text,
      "imageUrl":urlimage.toString(),"category":_categoryController.text,"about":_aboutController.text,
      "uid":uid
    };
    //String name=_NameController.text;
    //print(name);
    Map <String,dynamic> cat={
      "category":_categoryController.text,
    };
    // FirebaseFirestore.instance.collection(uid).doc("products").collection("Products").add(data);
    //id++;
    FirebaseFirestore.instance.collection(uid).doc("products").collection("products").doc(_NameController.text).set(data);
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct()));
    FirebaseFirestore.instance.collection(uid).doc("categories").collection("Categories").add(cat);
    FirebaseFirestore.instance.collection(uid).doc("categories").collection(_categoryController.text).doc(_NameController.text).set(data);
    Navigator.pop(context);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar:AppBar (
        backgroundColor: Colors.blue,
        title: (
            Text("Add Products",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)
        ),
        /*   actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct()));
            },
            icon: Icon(Icons.add_box,color: Colors.black,size: 30,),
          ),


        ],*/

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //image
              // Image.asset('assets/images/k5.png',height: 120,),
              //title
              SizedBox(height: 20,),
              // Text("Sign uP",style:TextStyle(color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),

              //subtitle
              SizedBox(height: 20,),
              Text("Welcome , here you can Add Your products :)",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

              //username
              SizedBox(height: 30,),

              image!=null?Image.file(image!,width:160,height:160):Image.asset("assets/images/koala3.png",width: 160,height: 160,),//FlutterLogo(size: 160,),
              Container(
                padding: EdgeInsets.all(10),
                child: RaisedButton(onPressed: (){
                  Pickerimage();
                },
                  child: Text("اختر صورة",style: TextStyle(color: Colors.white),),
                  color: Colors.orange.shade900,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _NameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Product Name',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Price',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _discountController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Discount',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Category',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _aboutController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'about products',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: Saveproduct,
                  child: Container(
                    padding:EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                    Center(child: Text("Save Product",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
