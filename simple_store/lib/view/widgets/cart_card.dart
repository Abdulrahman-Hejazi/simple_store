import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_store/logic/cart/cart_bloc.dart';
import 'package:simple_store/model/cart_item.dart';
import 'package:simple_store/view/routes.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartItem cart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, productDetails, arguments: cart.item);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cart.item.title,
                style: TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "\$${cart.item.price}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                  children: [],
                ),
              )
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              MaterialButton(
                onPressed: () {
                  BlocProvider.of<CartBloc>(context).add(
                      CartItemModified(cart.item, cart.numOfItem + 1));
                },
                child: Icon(
                  EvaIcons.plus,
                  size: 15,
                ),
              ),
              Text("x${cart.numOfItem}",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1),
              MaterialButton(
                onPressed: () {
                  BlocProvider.of<CartBloc>(context).add(
                      CartItemModified(cart.item, cart.numOfItem - 1));
                  if (cart.numOfItem < 1){
                    BlocProvider.of<CartBloc>(context).add(CartItemRemoved(cart));
                  }
                },
                child: Icon(
                  EvaIcons.minus,
                  size: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}