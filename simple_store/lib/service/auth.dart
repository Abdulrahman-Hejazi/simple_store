import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_store/data/constants.dart';
import 'package:simple_store/model/category.dart';
import 'package:simple_store/model/products.dart';
import 'package:simple_store/model/user.dart';
import 'package:simple_store/model/user_creditials.dart';
import '../model/login_response.dart';



class Auth{

  Future signOut(String token) async {
    try {
      Map <String ,String> headers = {
        'Authorization' : 'Bearer $token'
      };

      final response = await http.post(
        Uri.parse(url + logoutPath),
        headers: headers,

      );
      print(response.body);
      if (jsonDecode(response.body)['message'] != 'You have been successfully logged out!') {
        print('something went wrong');
      }
    }
    catch(e){
      print(e);
      return null;
    }

  }

  Future signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(url + loginPath),
        body: UserCredintials(email, password).toJson(),
      );
      print(response.body);
      if (jsonDecode(response.body)['message'] != null) {
        print('invalid credintials');
        return null;
      }
      else {
        LoginResponse loginResponse =
        LoginResponse.fromJson(jsonDecode(response.body));
        return loginResponse;
      }
    }
    catch(e){
      print(e);
      return null;
    }
  }


  Future getUser(String token) async {
    Map <String ,String> headers = {
      'Authorization' : 'Bearer $token'
    };
    final response = await http.get(
        Uri.parse(url+getUserPath),
        headers: headers
    );
    return (User.fromJson(jsonDecode(response.body)));
  }


  Future getAllProducts() async {
    final response = await http.get(
        Uri.parse(url+getProductsPath),
    );
    List<Product> products = List<Product>.generate(jsonDecode(response.body).length, (index) {
      return Product.fromJson(jsonDecode(response.body)[index]);
    });
    return products;
  }

  getProductsInCategory(int id) async {
    final response = await http.get(Uri.parse(url+getCategoriesPath+'/$id/'));


    List<Product> products = List<Product>.generate(jsonDecode(response.body)['products'].length, (index) {
      print(jsonDecode(response.body)['products'][index]);
      return Product.fromJson(jsonDecode(response.body)['products'][index]);
    });


    return products;
  }

  Future<List<Category>> getAllCategories() async {
    try {
      final response = await http.get(Uri.parse(url + getCategoriesPath));

      List<Category> categories = List<Category>.generate(
          jsonDecode(response.body).length, (index) {
        return Category.fromJson(jsonDecode(response.body)[index]);
      });

      return categories;
    }
    catch(e){
      print(e);
      return [];
    }
  }



}