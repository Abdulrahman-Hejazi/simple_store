


class User{
  User({required this.name,required this.email,required this.id});
  String name;
  String email;
  int id;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      id: json['id'],
      email: json['email'],
    );
  }


}