
import 'package:simple_store/model/products.dart';
import 'package:simple_store/service/auth.dart';


class ProductRepo{

  List<Product> _products = [];
  Auth _auth = Auth();

  Future<List<Product>> loadProducts() async {
    _products = await _auth.getAllProducts();
    return _products;
  }

  Future<List<Product>> loadProductsInCateggory(int id) async {
    _products = await _auth.getProductsInCategory(id);
    return _products;

  }

}