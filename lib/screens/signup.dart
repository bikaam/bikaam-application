import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/vendersignup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home/homescreen2.dart';

const List<String> list = <String>["قنا",];
const List<String> qena = <String>["مركز قنا","قفط","نجع حمادي","نقادة","دشنا","فرشوط"];
const List<String> Luxor = <String>["ادفو","اسنا","الاقصر"];



class SignUpScreen extends StatefulWidget {
  late String phonenumber;
  SignUpScreen({required this.phonenumber});
  //const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState(phonenumber);
}

class _SignUpScreenState extends State<SignUpScreen> {
  String phonenumber;
  _SignUpScreenState(this.phonenumber);

  FirebaseAuth _auth = FirebaseAuth.instance;
  late List<String> newlist=[];
  String dropdownValue = list.first;
  String dropdownValue2 = qena.first;

  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _ConpasswordController=TextEditingController();
  final _NameController=TextEditingController();
  final _AddressController=TextEditingController();
  final _PhoneController=TextEditingController();
  final _otpController=TextEditingController();
  late String verificationId;

 // late List<String> newlist=[];

  late String users;
  int sum=0;
  void getUsersData() {
    //FirebaseAuth auth= FirebaseAuth.instance;
    // String uid=auth.currentUser!.uid.toString();
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection("admin").doc("users").collection("users");
    usersCollection.doc("users").get().then((value) {
      var fields = (value.data() as Map<String,dynamic>);
      setState(() {
        users = fields["value"] ;
        print("users");
        print(users);
      });
    });
    sum=int.parse(users)+1;
    print("sum");
    print(sum);
    usersCollection
        .doc("users") // <-- Doc ID where data should be updated.
        .update(
        {
          'value':sum.toString(),
        });
  }

  bool showLoading = false;
  bool city=false;
  String cityvalue="اختر محافظة";
  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential)
  async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        FirebaseAuth auth= FirebaseAuth.instance;
        String uid=auth.currentUser!.uid.toString();
        //String phonenum ="+2"+_PhoneController.text;
        Map <String,dynamic> data={"name":_NameController.text,"address":_AddressController.text
          ,"phone":phonenumber,"cashback":"0","messages":"0",
          "following":"0","cartnum":"0","notifynum":"0","isSelected":false};
       // Map <String,dynamic> userid={"phone":phonenumber,"password":_passwordController.text};
        if(cityvalue=="قنا"){
          FirebaseFirestore.instance.collection("user").doc(phonenumber).set(data);

        }
        else{
          FirebaseFirestore.instance.collection(cityvalue).doc("user").collection("user").doc(phonenumber).set(data);

        }
        FirebaseFirestore.instance.collection(uid).doc(uid).set(data);
        getUsersData();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        //showLoading = false;
      });

     if(authCredential.user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen2()));
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }

  }

  bool passwordConfirmed(){
      if(_passwordController.text.trim()==_ConpasswordController.text.trim()){
        return true;
      }else
        {
          return false;
        }

    }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
      Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/logo.png',height: 120,),

              Text("انشاء حساب",style:TextStyle(color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10,top: 15),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.right,

                        controller: _NameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'اسم المستخدم',
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
                   /* Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text("الادارة",style: TextStyle(fontWeight: FontWeight.bold),),
                    ),*/
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
                child:InkWell(
                  onTap: (){
                    setState(() {
                      city=true;
                    });
                  },
                    child: Text(cityvalue)
                ),
              ),


              //////////////////////////////////////


              //user address
/////////////////////////////////////////////////////////////////////////
              SizedBox(height: 10,),
              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
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

              //user phone
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

              //sign in button
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: (){
                    if(phonenumber!=null&&_NameController.text!=null&&_AddressController.text!=null&&_passwordController.text!=null) {
                      showDialog(context: context, builder: (context) {
                            return Center(child: CircularProgressIndicator(),);
                          }
                      );
                      FirebaseAuth auth = FirebaseAuth.instance;
                      String uid = auth.currentUser!.uid.toString();
                      // String phonenum ="+2"+_PhoneController.text;
                      Map <String, dynamic> data = {
                        "name": _NameController.text,
                        "address": _AddressController.text,
                        "phone": phonenumber,
                        "cashback": "0",
                        "messages": "0",
                        "following": "0",
                        "cartnum": "0",
                        "notifynum": "0",
                        "isSelected":false,
                        "password":_passwordController.text,
                        "uid":uid.toString(),
                        "city":cityvalue.toString(),

                      };
                      FirebaseFirestore.instance.collection(uid).doc(uid).set(data);

                      if(cityvalue=="قنا"){
                        FirebaseFirestore.instance.collection("user").doc(phonenumber).set(data);

                      }
                      else{
                        FirebaseFirestore.instance.collection(cityvalue).doc("user").collection("user").doc(phonenumber).set(data);

                      }

                      //getUsersData();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));}
                    else{
                      var altertDialog = AlertDialog(
                        title: Row(children: [
                          // Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                        ],),
                        content:
                        Text("برجاء ملئ البيانات اولا "),
                      );
                      showDialog(context: context, builder: (BuildContext context)
                      {
                        return altertDialog;
                      });
                    }
                  },
                  child: Container(
                    padding:EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                    Center(child: Text("انشاء حساب",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                ),
              ),
              InkWell(
                onTap:(){
               //   String phonenum ="+2"+_PhoneController.text;
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => VenderSignUp(phonenumber:phonenumber,)));
                } ,
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, top: 20),
                  child: Row(
                    children: [
                      Text(
                        "انشاء حساب  " ,style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "لتاجر ",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),


                ),
              )

            ],
          ),
        ),
      ),
    );
  }

}

