import 'package:flutter/material.dart';
class ShowDiscount extends StatefulWidget {
  late String value;
  ShowDiscount({required this.value});


  @override
  State<ShowDiscount> createState() => _ShowDiscountState(value);
}

class _ShowDiscountState extends State<ShowDiscount> {
  String value;

  _ShowDiscountState(this.value);


  @override
  Widget build(BuildContext context) {
    if (value == "") {
      return Container();
    }
    else {
      return Positioned(
        top: 10,
        left: 5,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.red,
          child: Text(value+"%",style: TextStyle(fontSize: 12),),
        ),
      );
    }
  }
}
