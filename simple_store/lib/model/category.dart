class Category {
  Category({required this.title, required this.id});

  int id;
  String title;


  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      title: json['title'],
      id: json['id'],
    );
  }


}
