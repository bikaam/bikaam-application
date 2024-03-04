class Category {
  final String icon, title;

  Category({required this.icon, required this.title});
}

List<Category> demo_categories = [
  Category(
    icon: "assets/icons/shirt.svg",
    title: "clothes",
  ),
  Category(
    icon: "assets/icons/svg.svg",
    title: " electronics",
  ),
  Category(
    icon: "assets/icons/animals.svg",
    title: "Animals",
  ),
  Category(
    icon: "assets/icons/1.svg",
    title: "Others",
  ),
];
