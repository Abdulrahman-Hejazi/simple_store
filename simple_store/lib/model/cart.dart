


import 'package:equatable/equatable.dart';
import 'package:simple_store/model/cart_item.dart';

class Cart extends Equatable {
  const Cart({this.items = const <CartItem>[]});

  final List<CartItem> items;

  double get totalPrice {
    double totalPrice = 0;
    items.forEach((element) {
      totalPrice += element.item.price * element.numOfItem;
    });
    return totalPrice;
  }

  @override
  List<Object> get props => [items];
}

