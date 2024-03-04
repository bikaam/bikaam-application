import 'package:bikaam/SignScreen.dart';
import 'package:bikaam/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
class Log extends StatefulWidget {
  const Log({Key? key}) : super(key: key);

  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],

    body:Column(
      children: [
        SizedBox(height: 30,),
        Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {

                    //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                    },
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.grey[400],
                      size: 30,
                    ),
                  ),
                  // CartNum(),
                ],
              ),
              // const SizedBox(width: defaultPadding),
              SvgPicture.asset("assets/icons/Location.svg"),
              const SizedBox(width: defaultPadding /2),
              Text(
                "Qena",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 100,
                ),
              ),
              Stack(
                children: [
                  IconButton(
                    icon: SvgPicture.asset("assets/icons/Notification.svg"),
                    onPressed: () {
                   //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowNotify()));

                    },
                  ),
                  //NotifyNum(),
                ],
              ),
              Stack(
                children: [
                  Container(
                    child: IconButton(
                      onPressed: () {
                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowMessages()));
                      },
                      icon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey[400],
                        size: 30,
                      ),
                    ),
                  ),

                  //MessageNum(),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 200,),
        Center(
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
            },
            child: Container(
              width: 100,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: Colors.black)
                ),
                child: Center(child: Text("Login"))
            ),
          ),
        )
      ],
    )
    );
  }
}
