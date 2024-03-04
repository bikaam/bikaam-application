import 'package:bikaam/screens/home/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:stylish/models/Category.dart';

import '../../../constants.dart';
import '../../../models/Category.dart';

class Categories extends StatelessWidget {
  late String value;

 // Categories({required this.value})


  @override
  Widget build(BuildContext context) {
    String value;
    //_CategoriesState(this.value);
    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: demo_categories.length,
        itemBuilder: (context, index) => CategoryCard(
          icon: demo_categories[index].icon,
          title: demo_categories[index].title,
          press: () {},
        ),
        separatorBuilder: (context, index) =>
            const SizedBox(width: defaultPadding),
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String icon, title;
  final VoidCallback press;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  Go(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryShow(value: widget.title, city: '',)));
    print(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: Go,
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 2, horizontal: defaultPadding / 4),
        child: Column(
          children: [
            SvgPicture.asset(widget.icon,height: 37,width: 28,),
            const SizedBox(height: defaultPadding / 2),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
