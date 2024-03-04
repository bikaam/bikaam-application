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

  _AddUsedProductsState();
  @override
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
  TextEditingController _sellernameController= TextEditingController();
  TextEditingController _addressController= TextEditingController();
  TextEditingController  _aboutController= TextEditingController();
  TextEditingController  _phoneController= TextEditingController();
  TextEditingController _text = TextEditingController();
  TextEditingController size = TextEditingController();
  var  category;
  List<String> ChoseColor=[];
  List<String> ChoseSize=[];

  Choosecolor(){
    var altertDialog = AlertDialog(


      title: Row(children: [
        Text("اضافة الالوان المتاحة",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
        //Text(document['code'],style: TextStyle(color: Colors.black,fontSize: 20),),

      ],),

      content:
      Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: _text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "ادخل اللون ",
              ),
            ),
            SizedBox(height: 20,),
            FloatingActionButton.extended(
              onPressed: () {
                //String collor=_text as String;
                ChoseColor.add(_text.text);
                print(ChoseColor);

                Navigator.pop(context);

              },
              backgroundColor: Color(0xFFECF2FF),
              elevation: 0,
              label: const Text("حفظ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),



    );
    showDialog(context: context, builder: (BuildContext context)
    {
      return altertDialog;
    });
  }
  ChooseSizes(){
    var altertDialog = AlertDialog(


      title: Row(children: [
        Text("اضافة المقاسات المتاحة",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
        //Text(document['code'],style: TextStyle(color: Colors.black,fontSize: 20),),

      ],),

      content:
      Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: size,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "ادخل المقاس ",
              ),
            ),
            SizedBox(height: 20,),
            FloatingActionButton.extended(
              onPressed: () {
                //String collor=_text as String;
                ChoseSize.add(size.text);
                print(ChoseSize);

                Navigator.pop(context);

              },
              backgroundColor: Color(0xFFECF2FF),
              elevation: 0,
              label: const Text("حفظ",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),



    );
    showDialog(context: context, builder: (BuildContext context)
    {
      return altertDialog;
    });
  }

  ChooseCat(){

    var altertDialog = AlertDialog(


      title: Row(children: [
        Text("Choose Category",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
        //Text(document['code'],style: TextStyle(color: Colors.black,fontSize: 20),),

      ],),

      content: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:40),
            child: GestureDetector(
              onTap: Men,
              child: Container(
                  padding:EdgeInsets.all(17   ),
                  //color: Colors.cyan[100],
                  decoration: BoxDecoration(
                    //color: Colors.teal[100],
                    color: Color(0xFFECF2FF),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.man,color: Colors.cyan[200],size: 30,),
                      SizedBox(width: 10,),
                      Text("ملابس",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

                    ],
                  )
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:40),
            child: GestureDetector(
              onTap: Women,
              child: Container(
                  padding:EdgeInsets.all(17   ),
                  //color: Colors.cyan[100],
                  decoration: BoxDecoration(
                    //color: Colors.teal[100],
                    color: Color(0xFFECF2FF),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.woman,color: Colors.cyan[200],size: 30,),
                      SizedBox(width: 10,),
                      Text("الكترونيات",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

                    ],
                  )
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:40),
            child: GestureDetector(
              onTap: Kids,
              child: Container(
                  padding:EdgeInsets.all(17   ),
                  //color: Colors.cyan[100],
                  decoration: BoxDecoration(
                    //color: Colors.teal[100],
                    color: Color(0xFFECF2FF),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.child_care,color: Colors.cyan[200],size: 30,),
                      SizedBox(width: 10,),
                      Text("حيوانات اليفة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

                    ],
                  )
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:40),
            child: GestureDetector(
              onTap: Other,
              child: Container(
                  padding:EdgeInsets.all(17   ),
                  //color: Colors.cyan[100],
                  decoration: BoxDecoration(
                    //color: Colors.teal[100],
                    color: Color(0xFFECF2FF),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.new_releases_outlined,color: Colors.cyan[200],size: 30,),
                      SizedBox(width: 10,),
                      Text("متنوع",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

                    ],
                  )
              ),
            ),
          ),



        ],
      ),


    );
    showDialog(context: context, builder: (BuildContext context)
    {
      return altertDialog;
    });

  }
  Men(){
    category="clothes";
    Navigator.pop(context);
  }
  Women(){
    category="electronic";
    Navigator.pop(context);
  }
  Kids(){
    category="pets";
    Navigator.pop(context);
  }
  Other(){
    category="other";
    Navigator.pop(context);
  }

  Saveproduct() async {
    FirebaseAuth auth= FirebaseAuth.instance;
    String uid=auth.currentUser!.uid.toString();
    var StorageImage= FirebaseStorage.instance.ref().child(image!.path);
    var task=StorageImage.putFile(image!);
    final snapshot = await task.whenComplete(() {});
    urlimage = await snapshot.ref.getDownloadURL();
    //print(uid);

    Map <String,dynamic> data={"name":_NameController.text,"price":_priceController.text,
      "imageUrl":urlimage.toString(),"category":category.toString(),"about":_aboutController.text,
      "phone":_phoneController.text,"address":_addressController.text,"sellername":_sellernameController.text,
      "uid":uid,"Colors":ChoseColor,"Sizes":ChoseSize,
    };

    FirebaseFirestore.instance.collection(category.toString()).doc(uid+_NameController.text).set(data);
    FirebaseFirestore.instance.collection(uid).doc("orders").collection("Products").add(data);
    FirebaseFirestore.instance.collection("admin").doc("usedproducts").collection("usedproducts").add(data);


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
                      controller: _aboutController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'about products',
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
                      controller: _sellernameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Vendor name',
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
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'phone number',
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
                      controller: _addressController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'address',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: Choosecolor,
                  child: Container(
                    padding:EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                    Center(child: Text("add color",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: ChooseSizes,
                  child: Container(
                    padding:EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                    Center(child: Text("add Sizes",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: ChooseCat,
                  child: Container(
                    padding:EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                    Center(child: Text("Category",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
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
