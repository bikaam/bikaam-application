import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../constants.dart';
import '../size_config.dart';


class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Image.asset(
          "assets/images/logo.png"!,
          height: 100,
          width: 300,
          //height: getProportionateScreenHeight(265),
         // width: getProportionateScreenWidth(235),
        ),

        Text(
          text!,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          image!,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
