class ExampleData {
  ExampleData._internal();

  static List<String> images = [
    "https://github.com/wayne900204/vertical_scrollable_tabview/blob/main/example/assets/food.jpeg?raw=true",
    "https://github.com/wayne900204/vertical_scrollable_tabview/blob/main/example/assets/food.jpeg?raw=true",
    "https://github.com/wayne900204/vertical_scrollable_tabview/blob/main/example/assets/food.jpeg?raw=true",
    "https://github.com/wayne900204/vertical_scrollable_tabview/blob/main/example/assets/food.jpeg?raw=true",
    "https://github.com/wayne900204/vertical_scrollable_tabview/blob/main/example/assets/food.jpeg?raw=true",
  ];

  static List<Category> data =
   [
      category1,
      category2,
      category3,
      category4,
      category4,
      category4,
      category3,
      category4,
      category4,
      category3,
    ];

  static Category category1 = Category(
    title: "人氣火鍋",
    subtitle: "附副餐一份，鍋類肉品「煙嶿肉、醃牛肉」，擇一",
    isHotSale: true,
    foods: List.generate(
      5,
          (index) {
        return Food(
          name: "701. 超人氣泡菜鍋",
          price: "200",
          comparePrice: "\$198",
          imageUrl: images[index % images.length],
          isHotSale: false,
        );
      },
    ),
  );

  static Category category2 = Category(
    title: "特級火鍋",
    subtitle: "附副餐一份",
    isHotSale: false,
    foods: List.generate(
      3,
          (index) {
        return Food(
          name: "706. 迷你原味鍋",
          price: "230",
          comparePrice: "\$250",
          imageUrl: images[index % images.length],
          isHotSale: index == 2 ? true : false,
        );
      },
    ),
  );

  static Category category3 = Category(
    title: "經典火鍋",
    subtitle: null,
    isHotSale: false,
    foods: List.generate(
      1,
          (index) {
        return Food(
          name: "經典火鍋",
          price: "258",
          comparePrice: "\$289",
          imageUrl: images[index % images.length],
          isHotSale: false,
        );
      },
    ),
  );

  static Category category4 = Category(
    title: "素食火鍋",
    subtitle: "附附餐一份，可烹煮為鍋邊素，若有需要請備著告知",
    isHotSale: false,
    foods: List.generate(
      5,
          (index) {
        return Food(
          name: "728. 連庭素食鍋",
          price: "240",
          comparePrice: "\$300",
          imageUrl: images[index % images.length],
          isHotSale: index == 3 ? true : false,
        );
      },
    ),
  );
}

class Category {
  String title;
  String? subtitle;
  List<Food> foods;
  bool isHotSale;

  Category({
    required this.title,
    required this.subtitle,
    required this.foods,
    required this.isHotSale,
  });
}

class Food {
  String name;
  String price;
  String comparePrice;
  String imageUrl;
  bool isHotSale;

  Food({
    required this.name,
    required this.price,
    required this.comparePrice,
    required this.imageUrl,
    required this.isHotSale,
  });
}
