class UserCredintials {
  UserCredintials(this.email, this.password);
  String email;
  String password;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
