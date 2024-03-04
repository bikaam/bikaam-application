import 'package:bikaam/SignScreen.dart';
import 'package:bikaam/screens/home/home_screen.dart';
import 'package:bikaam/screens/loginscreen.dart';
import 'package:bikaam/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}
class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}


class _PasswordState extends State<Password> {
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


  final password=TextEditingController();
  final repassword=TextEditingController();
  final phone=TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool passwordConfirmed(){
    if(password.text.trim()==repassword.text.trim()){
      return true;
    }else
    {
      return false;
    }

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
      Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50,),
              Container(
                child: Image.asset("assets/images/splash_1.png",height: 250,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25.0),
                child: Center(child: Text("اعادة تعيين كلمة السر ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
              ),
              SizedBox(height: 20,),
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
                            border: Border.all(color: Colors.black)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // hintText: 'رقم الهاتف',
                              labelText: "ادخل رقم الهاتف",
                              prefixIcon:Icon( Icons.phone
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "ادخل رقم الهاتف";
                              }else{
                                return null;
                              }
                            },
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
                            border: Border.all(color: Colors.black)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: password,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // hintText: 'رقم الهاتف',
                              labelText: "ادخل كلمة السر الجديدة",
                              prefixIcon:Icon( Icons.lock
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "ادخل كلمة السر الجديدة";
                              }else{
                                return null;
                              }
                            },
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
                            border: Border.all(color: Colors.black)

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: repassword,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                //hintText: 'كلمة المرور',
                                labelText: 'اعادة ادخال كلمة السر ',
                                prefixIcon:Icon( Icons.lock)
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "اعادة ادخال كلمة السر ";
                              }else{
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: GestureDetector(
                        onTap: ()async{
                          /* if(formKey.currentState!.validate()){
                        final snackBar=SnackBar(content: Text('ادخل البيانات المطلوبة'));
                        _scaffoldKey.currentState!.showSnackBar(snackBar);
                      }*/


                          String phonenum="+2"+phone.text;
                          print(phonenum);

                          final user = FirebaseFirestore.instance.collection("user").doc(phonenum);

                          if (((await user.get())!.exists)) {
                            if(passwordConfirmed()){
                              Map <String,dynamic> userid={"password":password.text};
                              //FirebaseFirestore.instance.collection("user").doc(phonenum).set(userid);
                              FirebaseFirestore.instance.collection("user").doc(phonenum).update({"password":password.text});
                              //String phonenum="+2"+_PhoneController.text;


                              //String phonenum="+2"+_PhoneController.text;

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

                            }
                            else{
                              var altertDialog = AlertDialog(
                                title: Row(children: [
                                  // Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                                ],),
                                content:
                                Text("يجب تطابق كلمةالمرور"),

                              );
                              showDialog(context: context, builder: (BuildContext context)
                              {
                                return altertDialog;
                              });
                            }
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen2()));
                          }
                          else {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                          };

                        },
                        child: Container(
                          padding:EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:
                          Center(child: Text("تغيير كلمة السر",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                        ),
                      ),
                    ),
                  ],
                ),

              ),

             /* Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () async {
                    String phonenum="+2"+_PhoneController.text;


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
              ),*/

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
              Image.asset('assets/images/splash_1.png',height: 200,),
              //title
              SizedBox(height: 20,),
              Text("اعادة تعيين كلمة المرور",style:TextStyle(color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),

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
  /*Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   /* return Scaffold(
      body:ListView(
        children: [
          SizedBox(height: 50,),
          Container(
            child: Image.asset("assets/images/splash_1.png",height: 250,),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: Center(child: Text("اعادة تعيين كلمة السر ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
          ),
          SizedBox(height: 20,),
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
                        border: Border.all(color: Colors.black)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // hintText: 'رقم الهاتف',
                          labelText: "ادخل رقم الهاتف",
                          prefixIcon:Icon( Icons.phone
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "ادخل رقم الهاتف";
                          }else{
                            return null;
                          }
                        },
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
                        border: Border.all(color: Colors.black)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // hintText: 'رقم الهاتف',
                          labelText: "ادخل كلمة السر الجديدة",
                          prefixIcon:Icon( Icons.lock
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "ادخل كلمة السر الجديدة";
                          }else{
                            return null;
                          }
                        },
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
                        border: Border.all(color: Colors.black)

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: repassword,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            //hintText: 'كلمة المرور',
                            labelText: 'اعادة ادخال كلمة السر ',
                            prefixIcon:Icon( Icons.lock)
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "اعادة ادخال كلمة السر ";
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: ()async{
                     /* if(formKey.currentState!.validate()){
                        final snackBar=SnackBar(content: Text('ادخل البيانات المطلوبة'));
                        _scaffoldKey.currentState!.showSnackBar(snackBar);
                      }*/
                      String phonenum="+2"+phone.text;
                      print(phonenum);

                      final user = FirebaseFirestore.instance.collection("user").doc(phonenum);

                      if (((await user.get())!.exists)) {
                        if(passwordConfirmed()){
                          Map <String,dynamic> userid={"password":password.text};
                          FirebaseFirestore.instance.collection("user").doc(phonenum).set(userid);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        }
                        else{
                          var altertDialog = AlertDialog(
                            title: Row(children: [
                              // Text("عميلنا المميز",style: TextStyle(color: Colors.cyan[900] ,fontSize: 20),),
                            ],),
                            content:
                            Text("يجب تطابق كلمةالمرور"),

                          );
                          showDialog(context: context, builder: (BuildContext context)
                          {
                            return altertDialog;
                          });
                        }
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen2()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                      };

                    },
                    child: Container(
                      padding:EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:
                      Center(child: Text("تغيير كلمة السر",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                    ),
                  ),
                ),
              ],
            ),

          ),






        ],
      ),
    );*/
  }*/
}
