


import 'package:simple_store/model/cart_item.dart';
import 'package:simple_store/model/products.dart';

class CartRepo{

  final List<CartItem> _products = [];

  loadCartItems() {
    return _products;
  }


  void modifyItemFromCart(Product item, int newQuantity) {
    for (int index = 0; index < _products.length; index++) {
      if (_products[index].item == item) {
        _products[index].numOfItem = newQuantity;

      }
    }
  }

  void removeItemFromCart(CartItem item) => _products.remove(item);

  void addItemToCart(CartItem item) {
    for (int index = 0; index < _products.length; index++) {
      if (_products[index].item == item.item) {
        _products[index].numOfItem += item.numOfItem;
        return;
      }
    }
    _products.add(item);
  }

  void cartClear(){
    _products.clear();
  }



}