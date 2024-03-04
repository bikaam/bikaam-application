
//import 'package:bikaamvendors/screens/vendersignup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';
class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
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


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    //phone.text="+2";

    return Scaffold(
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
                          String phonenum="+2"+phone.text;
                          print(phonenum);
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
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => VenderSignUp()));
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
    );
  }
}
