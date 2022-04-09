import 'package:flutter/material.dart';
import 'package:simple_store/model/products.dart';
import 'package:simple_store/view/screens/cart_screen.dart';
import 'package:simple_store/view/screens/home_screen.dart';
import 'package:simple_store/view/screens/product_details.dart';
import 'package:simple_store/view/screens/home_pages/profile_screen.dart';
import 'package:simple_store/view/wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      // case loginScreen:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());

      case productDetails:
        if (args is Product) {
          return MaterialPageRoute(builder: (_) => ProductDetails(product: args,));
        }
        return MaterialPageRoute(builder: (_) => const HomeScreen());


      case cartScreen:
        return MaterialPageRoute(builder: (_) => const CartScreen());

      case wrapper:
        return MaterialPageRoute(builder: (_) =>  Wrapper());

      case profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}

const homeScreen = '/homeScreen';
// const loginScreen = '/loginScreen';
const productDetails = '/ProductDetails';
const cartScreen = '/CartScreen';
const profileScreen = '/profileScreen';
const wrapper = '/';
