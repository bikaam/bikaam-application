//import 'dart:html';
import 'dart:io';
//import 'package:bikaamvendors/screens/venderAcount/venderprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

import 'home/home_screen.dart';
import 'home/homescreen2.dart';
const List<String> list = <String>['رجالي', 'نسائي', 'اطفالي', 'هدايا و هاند ميد'];
const List<String> list1 = <String>["قنا",];
const List<String> qena = <String>["مركز قنا","قفط","نجع حمادي","نقادة","دشنا","فرشوط"];

class VenderSignUp extends StatefulWidget {
  late String phonenumber;
  VenderSignUp({required this.phonenumber});
  //const VenderSignUp({Key? key}) : super(key: key);

  @override
  State<VenderSignUp> createState() => _VenderSignUpState(phonenumber);
}

class _VenderSignUpState extends State<VenderSignUp> {
  String phonenumber;
  _VenderSignUpState(this.phonenumber);
  bool city=false;
  String cityvalue="اختر محافظة";

  bool storeCate=false;
  String storevalue="اختر تصنيف المتجر";

   File? image;
   File? image2;
  late String urlimage;
   late String urlcover;
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

   Future Pickercover()async{
     try{
       final image2= await ImagePicker().pickImage(source: ImageSource.gallery);
       if(image2==null) return;
       final fileimage= File(image2.path);
       setState(() {
         this.image2=fileimage;
       });
     }on PlatformException catch(e){
       print("failed to pick image: $e");
     }
   }

   FirebaseAuth _auth = FirebaseAuth.instance;

  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _ConpasswordController=TextEditingController();
  final _NameController=TextEditingController();
  final _AddressController=TextEditingController();
  final _PhoneController=TextEditingController();
  final _ShopNameController=TextEditingController();
  final _aboutController=TextEditingController();
  TextEditingController _facebookController = TextEditingController();
   TextEditingController _whatsappController = TextEditingController();
   final _otpController=TextEditingController();
   late String verificationId;

   bool showLoading = false;
  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential)
  async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);


      setState(() async {
        FirebaseAuth auth= FirebaseAuth.instance;
        String uid=auth.currentUser!.uid.toString();

        var StorageImage= FirebaseStorage.instance.ref().child(image!.path);
        var task=StorageImage.putFile(image!);
        final snapshot = await task.whenComplete(() {});
        urlimage = await snapshot.ref.getDownloadURL();
        ////////////////////////
        var Storagecover= FirebaseStorage.instance.ref().child(image2!.path);
        var task2=StorageImage.putFile(image2!);
        final snapshot2 = await task.whenComplete(() {});
        urlcover = await snapshot.ref.getDownloadURL();
        print(uid);
        String phonenum ="+2"+_PhoneController.text;

        Map <String,dynamic> data= {
          "name": _NameController.text,
          "address": _AddressController.text,
          "shopname": _ShopNameController.text,
          "imageUrl": urlimage.toString(),
          "phone": phonenum,
          "orders": "0",
          "views": "0",
          "coverUrl": urlcover.toString(),
          "followers": "0",
          "category": category,
          "uid": uid,
          "whatsapp": _whatsappController.text,
          "facebook": _facebookController.text,
          'banner': "",
          "about": _aboutController.text,
          "messages": "0",
          "notifynum": "0",
          "cartnum":"0",
          "cashback":"0",
          "following":"0",
          "products":"0",
          "earn":"0",
          "sale":"0",
          "orderC":"0",
          "OrderCan":"0",
        };
        Map <String,dynamic> userid={"phone":phonenum,"password":_passwordController.text,"uid":uid,"name":_ShopNameController.text,
          "image":urlimage.toString(),"coverUrl":urlcover.toString()};

        Map <String,dynamic> adminvendor={"vendors":"0",};
        getUsersData();
        FirebaseFirestore.instance.collection('venders').doc(uid).set(data);
        FirebaseFirestore.instance.collection('vender').doc(phonenum).set(userid);
        //FirebaseFirestore.instance.collection('admin').doc("vendors").collection('vendor').add(adminvendor);

        FirebaseFirestore.instance.collection(uid).doc(uid).set(data);
        if(category=="men"){
          FirebaseFirestore.instance.collection("Men").add(data);
        }else if(category=="women"){
          FirebaseFirestore.instance.collection("Women").add(data);
        }else if (category=="kids"){
          FirebaseFirestore.instance.collection("Kids").add(data);
        }else{
          FirebaseFirestore.instance.collection("Others").add(data);
        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        showLoading = false;
      });

      if(authCredential.user != null){
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>VenderProfile()));
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.message.toString())));


     // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));


    }
  }
  var  category;
 late String vendors="0";
 int sum=0;
  void getUsersData() {
    //FirebaseAuth auth= FirebaseAuth.instance;
    // String uid=auth.currentUser!.uid.toString();
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection("admin").doc("vendors").collection("vendors");
    usersCollection.doc("value").get().then((value) {
      var fields = (value.data() as Map<String,dynamic>);
      setState(() {
        vendors = fields["vendors"] ;
        print("vendors");
        print(vendors);
      });
    });
    sum=int.parse(vendors)+1;
    print("sum");
    print(sum);
    usersCollection
        .doc("value") // <-- Doc ID where data should be updated.
        .update(
        {
          'vendors':sum.toString(),
        });
  }

  Future signup() async{

    showDialog(context: context,
        builder: (context){
      return Center(child: CircularProgressIndicator(),);
        }

    );

      FirebaseAuth auth= FirebaseAuth.instance;
      String uid=auth.currentUser!.uid.toString();

      var StorageImage= FirebaseStorage.instance.ref().child(image!.path);
      var task=StorageImage.putFile(image!);
      final snapshot = await task.whenComplete(() {});
      urlimage = await snapshot.ref.getDownloadURL();
      ////////////////////////
      var Storagecover= FirebaseStorage.instance.ref().child(image2!.path);
      var task2=StorageImage.putFile(image2!);
      final snapshot2 = await task.whenComplete(() {});
      urlcover = await snapshot.ref.getDownloadURL();
      print(uid);

      Map <String,dynamic> data= {
        "name": _NameController.text,
        "address": _AddressController.text,
        "shopname": _NameController.text,
        "imageUrl": urlimage.toString(),
        "phone": phonenumber,
        "orders": "0",
        "views": "0",
        "coverUrl": urlcover.toString(),
        "followers": "0",
        "cashback":"0",
        "category": category,
        "uid": uid,
        "whatsapp": " ",
        "facebook": " ",
        'banner': "",
        "about": _aboutController.text,
        "messages": "0",
        "notifynum": "0",
        "cartnum":"0",
        "products":"0",
        "earn":"0",
        "sale":"0",
        "orderC":"0",
        "OrderCan":"0",
        "following":"0",
        "city":cityvalue.toString(),
        "uid":uid.toString(),
        //"orderCont":"0"
      };
    Map <String,dynamic> userid={"phone":phonenumber,"password":_passwordController.text,"uid":uid,"name":_ShopNameController.text,
      "image":urlimage.toString(),"coverUrl":urlcover.toString()};

     Map <String,dynamic> adminvendor={"vendors":"0",};

      getUsersData();

    FirebaseFirestore.instance.collection('venders').doc(phonenumber).set(userid);

    if(cityvalue=="قنا"){
        FirebaseFirestore.instance.collection('vender').doc(uid).set(data);
      }
      else{
        FirebaseFirestore.instance.collection(cityvalue).doc("vendors").collection('Vendors').doc(uid).set(data);
      }
    //FirebaseFirestore.instance.collection('vender').doc(phonenumber.toString()).set(data);

    //FirebaseFirestore.instance.collection('vender').doc(uid).set(data);
      //FirebaseFirestore.instance.collection(cityvalue).doc("vendors").collection('Vendors').doc(uid).set(data);

      FirebaseFirestore.instance.collection('admin').doc("vendors").collection('vendor').add(adminvendor);
      FirebaseFirestore.instance.collection(uid).doc(uid).set(data);

      //FirebaseFirestore.instance.collection("Men").add(data);
    if(cityvalue=="قنا"){
      FirebaseFirestore.instance.collection("admin").doc("stores").collection("Stores").doc(storevalue).collection(storevalue).doc(_NameController.text).set(data);
    }
    else{
      FirebaseFirestore.instance.collection(cityvalue).doc("stores").collection("Stores").doc(storevalue).collection(storevalue).doc(_NameController.text).set(data);
    }

   /* if(category=="men"){
        FirebaseFirestore.instance.collection("Men").add(data);
      }else if(category=="women"){
        FirebaseFirestore.instance.collection("Women").add(data);
      }else if (category=="kids"){
        FirebaseFirestore.instance.collection("Kids").add(data);
      }else{
        FirebaseFirestore.instance.collection("Others").add(data);
      }*/

      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));


  }
  bool passwordConfirmed(){
    if(_passwordController.text.trim()==_ConpasswordController.text.trim()){
      return true;
    }else
    {
      return false;
    }

  }


  String dropdownValue1 = list1.first;
  String dropdownValue2 = qena.first;

  String dropdownValue = list.first;


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SizedBox(20),
              //image
              Image.asset('assets/images/logo.png',height: 150,),
              //title

              Text("انشاء حساب تاجر",style:TextStyle(color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),

              //username
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(right:5.0),
                child: Row(
                  children: [
                    image!=null?Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Container(width:140,child: Image.file(image!,width:150,height:160,fit:BoxFit.cover,)),
                    ):DottedBorder(
                      borderType: BorderType.RRect,
                      //strokeWidth: 2
                      //  strokeCap: StrokeCap.square,
                      dashPattern: [8,4],
                      radius: Radius.circular(12),
                      padding: EdgeInsets.all(6),
                      strokeWidth: 1.0,
                      strokeCap: StrokeCap.round,
                      color: Colors.cyan,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child:Container(height:160,width: 160,color: Colors.grey[200],child: Center(child: InkWell(
                            onTap: (){Pickerimage();},
                            child: Container(color:Colors.blue[800],child: Text("اختر صورة اللجو ",style: TextStyle(color: Colors.white),)))),),
                      ),
                    ),
                    SizedBox(width: 5,),
                    image2!=null?Container(width:140,child: Image.file(image2!,width:150,height:160,fit:BoxFit.cover,)):DottedBorder(
                      borderType: BorderType.RRect,
                      //strokeWidth: 2
                      //  strokeCap: StrokeCap.square,
                      dashPattern: [8,4],
                      radius: Radius.circular(12),
                      padding: EdgeInsets.all(6),
                      strokeWidth: 1.0,
                      strokeCap: StrokeCap.round,
                      color: Colors.cyan,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child:Container(height:160,width: 160,color: Colors.grey[200],child: Center(child: InkWell(
                            onTap: (){Pickercover();},
                            child: Container(color:Colors.blue[800],child: Text("اختر صورة الغلاف ",style: TextStyle(color: Colors.white),)))),),
                      ),
                    ),

                  ],
                ),
              ),//FlutterLogo(size: 160,),


              //Shop Name

              SizedBox(height: 10,),
              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10,top: 15),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.right,

                        controller: _NameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'اسم المتجر',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //////////////////////
              ///////////////////////////////////////////
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("المحافظة",style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(width: 60),

                  ],
                ),
              ),
              city?Padding(

                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                child: Container(
                  //height: 40,
                  width: 310,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child:  Container(

                    height: 100,
                    child:
                    StreamBuilder(
                        stream:FirebaseFirestore.instance.collection("admin").doc("city").collection("City").snapshots(),
                        builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Text('no values', style: TextStyle(color: Colors.black),);
                          }
                          return GestureDetector(
                            //onTap: goToCat,
                            child: Container(
                              // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                children: snapshot.data!.docs.map((document) {
                                  return
                                    Column(
                                      children: [
                                        Container(

                                          child:Row(
                                            children: [
                                              Container(
                                                width:150,
                                                child: Row(
                                                  children: [

                                                    InkWell(
                                                      onTap:(){
                                                        setState(() {
                                                          city=false;
                                                          cityvalue=document['city'];
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                        child: Text(document['city']),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 320,
                                          height: 1,
                                          decoration: BoxDecoration(
                                            // borderRadius: BorderRadius.circular(10),
                                            // color: Color(0xFFECF2FF),
                                              border: Border.all(color: Colors.black12)
                                          ),
                                        ),
                                      ],
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
              ):Container(
                height: 40,
                width: 310,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black12),

                ),
                child:InkWell(
                    onTap: (){
                      setState(() {
                        city=true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(cityvalue),
                    )
                ),
              ),

              //////////////////////////////////////


              //user address
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Row(
                  children: [
                    Text("اختر تصنيف المتجر "),
                  ],
                ),
              ),
              storeCate?Padding(

                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                child: Container(
                  //height: 40,
                  width: 310,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child:  Container(

                    height: 100,
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
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                children: snapshot.data!.docs.map((document) {
                                  return
                                    Column(
                                      children: [
                                        Container(

                                          child:Row(
                                            children: [
                                              Container(
                                                width:150,
                                                child: Row(
                                                  children: [

                                                    InkWell(
                                                      onTap:(){
                                                        setState(() {
                                                          storeCate=false;
                                                          storevalue=document['name'];
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                        child: Text(document['name']),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 320,
                                          height: 1,
                                          decoration: BoxDecoration(
                                            // borderRadius: BorderRadius.circular(10),
                                            // color: Color(0xFFECF2FF),
                                              border: Border.all(color: Colors.black12)
                                          ),
                                        ),
                                      ],
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
              ):Container(
                height: 40,
                width: 310,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black12),

                ),
                child:InkWell(
                    onTap: (){
                      setState(() {
                        storeCate=true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(storevalue),
                    )
                ),
              ),


              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _aboutController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'نبذة عن المتجر',

                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),
              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10,top: 15),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.right,

                        controller: _AddressController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'العنوان بالتفصيل',
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //user address
              SizedBox(height: 10,),

              SizedBox(height: 10,),
              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10,top: 15),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.right,
                        // scribbleEnabled: false,
                        obscureText: true,
                        controller:_passwordController,
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          hintText: 'كلمة السر',
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //Conpassword textfiled
              SizedBox(height: 17,),
              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10,top: 15),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.right,
                        // scribbleEnabled: false,
                        obscureText: true,
                        controller:_ConpasswordController,
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          hintText: 'اعادة كلمة السر',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),



              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () async {
                    signup();
                  },
                  child: Container(
                    height: 40,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
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
                    Center(child: Text("حفظ البيانات ",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                ),
              ),
              SizedBox(height: 25,),



            ],
          ),
        ),
      ),
    );

  }
}

