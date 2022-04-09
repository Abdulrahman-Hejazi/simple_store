import 'package:simple_store/model/category.dart';

class Product {
  Product({
    required this.id,
    required this.categories,
    required this.price,
    required this.title,
    required this.active,
    required this.stock,
  });

  int id;
  int price;
  bool active;
  int stock;
  String title;
  List<Category> categories;


  factory Product.fromJson(Map<String, dynamic> json) {
    Iterable? l = json['categories'];
    List<Category> categories = [] ;

    if (l != null){
      for (var value in l) {
        categories.add(Category(title: value['title'], id: value['id']));
      }

    }


    return Product(
      title: json['title'],
      id: json['id'],
      stock: json['stock'],
      price: json['price'],
      active: json['active'],
      categories: categories
    );
  }




}
