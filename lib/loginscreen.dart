
//import 'package:bikaamvendors/password.dart';
//import 'package:bikaamvendors/screens/venderAcount/venderprofile.dart';
//import 'package:bikaamvendors/screens/vendersignup.dart';
import 'package:bikaam/screens/password.dart';
import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/home/homescreen2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'SignScreen.dart';
enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}
String password="";
String Vendoruid="";
String name="";
String image="";
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final otpController = TextEditingController();
  final _phonenumber = TextEditingController();
  final _password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _otpController=TextEditingController();
  final _PhoneController=TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;
  LogIN() async {

    final user = FirebaseFirestore.instance.collection("user").doc(_phonenumber.text);
    if (((await user.get())!.exists)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else
      () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
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
  bool showLoading = false;
  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async{
    setState(() {
      showLoading=true;
    });
    try {
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading=false;
      });
      String num="+2"+_PhoneController.text;
      if(authCredential?.user != null){
        Navigator.push(context , MaterialPageRoute(builder: (context)=>HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      // TODO
      setState(() {
        showLoading= false;
      });
      _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(e.message.toString())));
    }

  }
  getMobileFormWidget(context) {
    // _PhoneController.text='+2';
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
      ListView(
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
                        /*   validator: (value) {
                          if (value!.isEmpty) {
                            return "ادخل كلمة المرور";
                          } else {
                            return null;
                          }
                        }, */
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: () async {
                      // final user = FirebaseFirestore.instance.collection("user").doc(_phonenumber.text);

                      /*  if (formKey.currentState!.validate()) {
                        final snackBar =
                            SnackBar(content: Text('ادخل البيانات المطلوبة'));
                        //_scaffoldKey.currentState!.showSnackBar(snackBar);
                      }

                      else{*/
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
                        if(password==_password.text){
                          setState(() {
                            //String phonenum="+2"+_PhoneController.text;

                            showLoading = true;
                          });
                          phone :phonenum;
                          await _auth.verifyPhoneNumber(
                              phoneNumber: phonenum,
                              // phoneNumber: '+2$(phone)',
                              verificationCompleted: (phoneAuthCredential) async {
                                setState(() {
                                  showLoading = false;
                                });
                                //signInWithPhoneAuthCredential(phoneAuthCredential);

                              },
                              verificationFailed: (verificationFailed) async {
                                setState(() {
                                  showLoading = false;
                                });
                                _scaffoldKey.currentState?.showSnackBar(SnackBar(
                                    content: Text(
                                        verificationFailed.message.toString())));
                              },
                              codeSent: (verificationId, resendingToken) async {
                                setState(() {
                                  showLoading = false;
                                  currentState =
                                      MobileVerificationState.SHOW_OTP_FORM_STATE;
                                  this.verificationId = verificationId;
                                });
                              },
                              codeAutoRetrievalTimeout: (verificationId) async {

                              }
                          );
                        }else {
                          var altertDialog = AlertDialog(
                            title: Row(children: [
                              // Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                            ],),
                            content:
                            Text("خطا في كلمة المرور"),
                          );
                          showDialog(context: context, builder: (BuildContext context)
                          {
                            return altertDialog;
                          });
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => VenderSignUp()));
                        };

                        //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen2()));
                      }
                      else {
                        var altertDialog = AlertDialog(
                          title: Row(children: [
                            // Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                          ],),
                          content:
                          Text("هذا الرقم غير مسجل من قبل من فضلك تاكد من رقم الهاتف"),
                        );
                        showDialog(context: context, builder: (BuildContext context)
                        {
                          return altertDialog;
                        });
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => VenderSignUp()));
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
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));

            },
            child: Padding(
              padding: const EdgeInsets.only(right: 220, top: 5),
              child: Text(
                "انشاء حساب جديد ",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );

  }

  getOtpFormWidget(context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
      Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //image
              Image.asset('assets/images/splash_1.png',height: 200,),
              //title
              SizedBox(height: 20,),
              Text("تسجيل الدخول",style:TextStyle(color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),

              //subtitle
              SizedBox(height: 20,),
              Text("من فضلك , ادخل الكود المرسل",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

              //username
              SizedBox(height: 30,),
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
                      controller: _otpController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'ادخل الكود',
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
                  onTap: ()async{

                    //PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpController.text);
                    //signInWithPhoneAuthCredential(phoneAuthCredential);

                    PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(verificationId: verificationId, smsCode: _otpController.text);
                    signInWithPhoneAuthCredential(phoneAuthCredential);


                  },
                  child: Container(
                    padding:EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                    Center(child: Text("تاكيد",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   // _phonenumber.text='+2';
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          color: Colors.white,
          child: showLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? getMobileFormWidget(context)
              : getOtpFormWidget(context),
          padding: const EdgeInsets.all(0),
        ));


  }
}
