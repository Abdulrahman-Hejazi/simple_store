import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simple_store/logic/cart/cart_bloc.dart';
import 'package:simple_store/model/cart_item.dart';
import 'package:simple_store/model/products.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({required this.product});

  final Product product;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: Transform.rotate(
              angle: 100,
              child: Text(
                widget.product.title.toString(),
                style: TextStyle(fontSize: 18, letterSpacing: 2),
              ),
            ),
          ),
          SizedBox(
            height: Get.height / 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.title,
                  style: TextStyle(fontSize: 16),
                ),
                Text('Price: ' + widget.product.price.toString() + 'LE',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "in stock: " + widget.product.stock.toString(),
              style: TextStyle(color: Colors.black.withAlpha(180)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor),
            child: const Text('add to cart'),
            onPressed: () {
              BlocProvider.of<CartBloc>(context).add(
                  CartItemAdded(CartItem(numOfItem: 1, item: widget.product)));
            },
          ),
          Wrap(
            children: List.generate(
                widget.product.categories.length,
                (index) => Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 50, 10),
                      child: Text(widget.product.categories[index].title),
                    )),
          )
        ],
      ),
    );
  }
}
