import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simple_store/logic/cart/cart_bloc.dart';
import 'package:simple_store/logic/category/category_bloc.dart';
import 'package:simple_store/logic/product_bloc/product_bloc.dart';
import 'package:simple_store/model/cart_item.dart';
import 'package:simple_store/model/products.dart';
import 'package:simple_store/service/auth.dart';
import 'package:simple_store/service/cache.dart';
import 'package:simple_store/view/routes.dart';

class HomePage extends StatelessWidget {
  List<bool> active = [true, false, true, false];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ProductError) {
        return Center(
          child: Text(
            'ERROR',
            style: TextStyle(
                color: Colors.red, fontSize: 30, fontWeight: FontWeight.w700),
          ),
        );
      } else if (state is ProductLoaded) {
        return BlocListener<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if (state is CategoryLoaded) {
              print('category selected ' + state.selectedCategory.toString());
              BlocProvider.of<ProductBloc>(context)
                  .add(ProductReload(state.selectedCategory));
            }
          },
          child: GridView.builder(
            itemCount: state.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () async {
                  Product product = await Auth().getProductByID(
                      state.products[index].id, await DataSaver.getData('token'));
                  Navigator.pushNamed(context, productDetails,
                      arguments: product);
                },
                child: Container(
                  color: Colors.white38,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 70,
                          left: Get.width / 20,
                          child: Transform.rotate(
                            angle: 100,
                            child: Text(
                              state.products[index].title.toString(),
                              style: TextStyle(fontSize: 12, letterSpacing: 2),
                            ),
                          )),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          color: Theme.of(context).backgroundColor,
                          height: 50,
                          width: Get.width / 2 - 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${state.products[index].price} LE'),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xffDA1212)),
                                onPressed: state.products[index].active
                                    ? () {
                                        BlocProvider.of<CartBloc>(context)
                                          ..add(CartItemAdded(CartItem(
                                              item: state.products[index],
                                              numOfItem: 1)));
                                      }
                                    : null,
                                child: Text('add to cart'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      !state.products[index].active
                          ? Positioned(
                              top: 60,
                              child: Container(
                                height: 30,
                                width: Get.width / 2,
                                color: Colors.grey.withAlpha(180),
                                child: Center(child: Text('not available')),
                              ))
                          : SizedBox(),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
