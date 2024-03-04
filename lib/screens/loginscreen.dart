import 'package:bikaam/SignScreen.dart';
import 'package:bikaam/auth2.dart';
import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/home/homescreen2.dart';
import 'package:bikaam/screens/password.dart';
import 'package:bikaam/screens/show/Log.dart';
import 'package:bikaam/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
String password="";
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phonenumber = TextEditingController();
  final _password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LogIN() async {

    final user = FirebaseFirestore.instance.collection("user").doc(_phonenumber.text);
    if (((await user.get())!.exists)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen2()));
    } else
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      };
   // Navigator.push(context, MaterialPageRoute(builder: (context) => Auth2()));
  }
  void getUsersData() {

    final CollectionReference usersCollection = FirebaseFirestore.instance.collection("user");
    usersCollection.doc(_phonenumber.text).get().then((value) {
      var fields = (value.data() as Map<String,dynamic>);
      setState(() {
        password = fields["password"] ;
        print(password);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            child: Image.asset(
              "assets/images/splash_1.png",
              height: 300,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
                child: Text(
              "تسجيل الدخول ",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _phonenumber,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // hintText: 'رقم الهاتف',
                          labelText: "ادخل رقم الهاتف",
                          prefixIcon: Icon(Icons.phone),
                        ),
                      /*  validator: (value) {
                          if (value!.isEmpty) {
                            return "ادخل رقم الهاتف";
                          } else {
                            return null;
                          }
                        },*/
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _password,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            //hintText: 'كلمة المرور',
                            labelText: 'ادخل كلمة المرور ',
                            prefixIcon: Icon(Icons.lock)),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Password()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 220, top: 5),
                    child: Text(
                      "نسيت كلمة المرور ؟ ",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
                //01004838147
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: () async {

                      String phonenum="+2"+_phonenumber.text;
                      print(phonenum);
                      CollectionReference usersCollection = FirebaseFirestore.instance.collection("user");
                      usersCollection.doc(phonenum).get().then((value) {
                        var fields = (value.data() as Map<String,dynamic>);
                        setState(() {
                          password = fields["password"] ;
                          print(password);
                        });
                      });

                        final user = FirebaseFirestore.instance.collection("user").doc(phonenum);

                        if (((await user.get())!.exists)) {
                          if(_password.text==password){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          }
                          else{
                            var altertDialog = AlertDialog(
                              title: Row(children: [
                               // Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                              ],),
                              content:
                              Text("خطأ في كلمة المرور "),

                            );
                            showDialog(context: context, builder: (BuildContext context)
                            {
                              return altertDialog;
                            });
                          }
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen2()));
                        } else {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => SignUpPage()));
                          };


                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  } ,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 100, top: 20),
                    child: Row(
                      children: [
                        Text(
                          "مستخدم جديد ؟ " ,style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                        ),
                        SizedBox(width: 20,),
                        Text(
                            "انشاء حساب ",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),


                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
