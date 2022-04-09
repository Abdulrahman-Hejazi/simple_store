class LoginResponse {
  LoginResponse(
      {required this.email,
      required this.name,
      required this.token,
      required this.id});

  String  email, token, name;
int id;
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      email: json['email'],
      id: json['id'],
      name: json['name'],
      token: json['token']
    );
  }

}
