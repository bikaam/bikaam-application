import 'package:flutter/material.dart';
class UsedCategory extends StatefulWidget {
  const UsedCategory({Key? key}) : super(key: key);

  @override
  State<UsedCategory> createState() => _UsedCategoryState();
}

class _UsedCategoryState extends State<UsedCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ماذا تريد ان تعرض"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close,color: Colors.black,size: 30,),
          ),


        ],
      ),
    );
  }
}

