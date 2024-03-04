
import 'package:flutter/material.dart';

import '../constants.dart';
class PriceDetails extends StatefulWidget {
  late String price , discount , after , cashback;
  PriceDetails({required this.price,required this.discount,required this.after,required this.cashback});


  @override
  State<PriceDetails> createState() => _PriceDetailsState(price,discount,after,cashback);
}

class _PriceDetailsState extends State<PriceDetails> {
  String price ,discount,after,cashback;

  _PriceDetailsState(this.price,this.discount,this.after,this.cashback);

  @override
  Widget build(BuildContext context) {
    if(discount!="0"){
      return  Row(
        children: [

          Text(
            discount.toString()+" EGP",
            style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 11),
          ),

          const SizedBox(width: defaultPadding/4 ),
          Text("بدلا من "),
          const SizedBox(width: defaultPadding /4),
          Text(
              price +" EGP",
              style: TextStyle(color: Colors.black,fontSize: 10)
          ),
        ],
      );
    }
    else{
      return Row(
        children: [

          Text(
            price+"EGP",
            style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 10),
          ),

          const SizedBox(width: defaultPadding/2 ),

          Text(
              cashback +" EGP ",
              style: TextStyle(color: Colors.black,fontSize: 10)
          ),
          Text("cashback " ,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 10),),
          const SizedBox(width: defaultPadding/4 ),

        ],
      );
    }
  }
}
