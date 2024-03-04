import 'package:bikaam/screens/show/bill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const List<String> list1 = <String>["قنا",];
const List<String> qena = <String>["مركز قنا","قفط","نجع حمادي","نقادة","دشنا","فرشوط"];

class OrderInfo extends StatefulWidget {
  late String Total,Sum,CouponValue;
  late List VendorList=[];
  OrderInfo({required this.Total,required this.Sum, required this.CouponValue,required this.VendorList});
  //const OrderInfo({Key? key}) : super(key: key);

  @override
  State<OrderInfo> createState() => _OrderInfoState(Total,Sum,CouponValue,VendorList);
}


class _OrderInfoState extends State<OrderInfo> {
  String Total,Sum,CouponValue;
  late List VendorList=[];
  _OrderInfoState(this.Total,this.Sum,this.CouponValue,this.VendorList);

  final _NameController=TextEditingController();
  final _AddressController=TextEditingController();
  final _phoneController=TextEditingController();
  final _phoneController2=TextEditingController();



  String dropdownValue1 = list1.first;
  String dropdownValue2 = qena.first;
  bool city=false;
  String cityvalue="اختر محافظة";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text("معلومات التوصيل",style: TextStyle(color: Colors.white),)),
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
      body: ListView(
        children: [
          Column(
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
                      color: Colors.grey[400],
                      size: 10,
                    ),
                    SizedBox(width: 15,),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[400],
                      size: 10,
                    ),
                    SizedBox(width: 15,),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[400],
                      size: 10,
                    ),
                    SizedBox(width: 15,),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[400],
                      size: 10,
                    ),
                    SizedBox(width: 15,),
                    Icon(
                      Icons.featured_play_list_outlined,
                      color: Colors.grey[400],
                      size: 25,
                    ),
                    SizedBox(width: 15,),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[400],
                      size: 10,
                    ),
                    SizedBox(width: 15,),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[400],
                      size: 10,
                    ),
                    SizedBox(width: 15,),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[400],
                      size: 10,
                    ),
                    SizedBox(width: 15,),
                    Icon(
                      Icons.circle,
                      color: Colors.grey[400],
                      size: 10,
                    ),
                    SizedBox(width: 15,),
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.grey[400],
                      size: 25,
                    ),
                    SizedBox(width: 15,),
                  ],
                ),
              ),
              SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.only(left: 200.0),
                child: Text("معلومات التوصيل ",style: TextStyle(color: Colors.cyan[800],fontWeight: FontWeight.bold,fontSize: 17),),
              ),
              SizedBox(height: 15,),
////////////////name////////////////////
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
                          hintText: 'الاسم ',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
//////////qena//////////////////////////
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child:  Container(

                    height: 80,
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
//////////////address///////////////////////////////////
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

                        controller: _phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'رقم الهاتف',
                        ),
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

                        controller: _phoneController2,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'رقم هاتف اخر (اختياري)',
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: ()  {
                    double x=double.parse(Total);
                    setState(() {
                      //total=s-int.parse(couponvalues);
                      x=x+50;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Bill(Sum: Sum, CouponValue:CouponValue, Total: Total.toString(), X: x.toString(), name:_NameController.text, address: _AddressController.text,
                       phone: _phoneController.text, VendorList: VendorList,)));

                    // signup();
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
                    Center(child: Text("الفاتورة",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
