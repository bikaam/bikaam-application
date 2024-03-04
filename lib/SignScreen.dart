import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/home/homescreen2.dart';
import 'package:bikaam/screens/signup.dart';
import 'package:bikaam/screens/vendersignup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'loginscreen.dart';

//import 'home/homescreen2.dart';
enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _ConpasswordController=TextEditingController();
  final _NameController=TextEditingController();
  final _AddressController=TextEditingController();
  final _PhoneController=TextEditingController();
  final _otpController=TextEditingController();
  late String verificationId;


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
        Navigator.push(context , MaterialPageRoute(builder: (context)=>SignUpScreen(phonenumber:num,)));
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
      Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30,),
              Image.asset('assets/images/logo.png',height: 300,width: 300,),
              SizedBox(height: 10,),
              Text("انشاء حساب",style:TextStyle(color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),


              //user phone
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      controller: _PhoneController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'رقم الهاتف',
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
                  onTap: () async {
                    String phonenum="+2"+_PhoneController.text;
                    final user = FirebaseFirestore.instance.collection("user").doc(phonenum);
                    //((await user.get())!.exists)
                    if (phonenum==null) {
                      var altertDialog = AlertDialog(
                        title: Row(children: [
                          // Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                        ],),
                        content:
                        Text("من فضلك ادخل رقم هاتف اخر غير مسجل مسبقا"),
                      );
                      showDialog(context: context, builder: (BuildContext context)
                      {
                        return altertDialog;
                      });

                    }else {
                      //String phonenum="+2"+_PhoneController.text;

                      setState(() {
                        //String phonenum="+2"+_PhoneController.text;

                        showLoading = true;
                      });
                      phone :
                      phonenum;
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text("لديك حساب ؟ ",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold),),
                  ),
                ),
              )
            ],
          ),
        ),
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
              Image.asset('assets/images/logo.png',height: 120,),
              //title
              SizedBox(height: 20,),
              Text("انشاء حساب",style:TextStyle(color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),

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
                    Center(child: Text("انشاء حساب",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }

  signup() async{
    String phonenum="+2"+_PhoneController.text;

    setState(() {
      showLoading = true;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: phonenum,
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
        _scaffoldKey.currentState!.showSnackBar(
            SnackBar(content: Text("verificationFailed.message")));
      },
      codeSent: (verificationId, resendingToken) async {
        setState(() {
          showLoading = false;
          currentState =
              MobileVerificationState.SHOW_OTP_FORM_STATE;
          this.verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );

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