import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_store/logic/cart/cart_repo.dart';
import 'package:simple_store/model/cart.dart';
import 'package:simple_store/model/cart_item.dart';
import 'package:simple_store/model/products.dart';


part 'cart_event.dart';
part 'cart_state.dart';


class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.cartRepo}) : super(CartLoading()) {
    on<CartStarted>(_onStarted);
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartItemModified>(_onItemModified);
    on<CartClear>(_onCartClear);
  }

  final CartRepo cartRepo;

  void _onStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final items = await cartRepo.loadCartItems();
      emit(CartLoaded(cart: Cart(items: [...items])));
    } catch (_) {
      emit(CartError());
    }
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        for (int index = 0; index < state.cart.items.length; index++) {
          if (state.cart.items[index].item == event.item.item) {
            state.cart.items[index].numOfItem += event.item.numOfItem;
            cartRepo.modifyItemFromCart(state.cart.items[index].item, state.cart.items[index].numOfItem);
            emit(CartLoaded(cart: Cart(items: [...state.cart.items])));
            return;
          }
        }
        cartRepo.addItemToCart(event.item);
        emit(CartLoaded(cart: Cart(items: [...state.cart.items, event.item])));
      } catch (_) {
        emit(CartError());
      }
    }
  }

  void _onItemModified(CartItemModified event, Emitter<CartState> emit) async {
    final state = this.state;
    int index;
    if (state is CartLoaded) {
      try {
        cartRepo.modifyItemFromCart(event.item, event.newQuantity);
        emit(CartLoaded(
            cart: Cart(items: [
              ...state.cart.items
            ])));
      } catch (_) {
        emit(CartError());
      }

    }
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        cartRepo.removeItemFromCart(event.item);
        emit(
          CartLoaded(
            cart: Cart(
              items: [...state.cart.items]..remove(event.item),
            ),
          ),
        );
      } catch (_) {
        emit(CartError());
      }
    }
  }

  void _onCartClear(CartClear event, Emitter<CartState> emit){
    if (state is CartLoaded){
      try{
        cartRepo.cartClear();
        emit(CartLoaded(cart: Cart(items: [])));
      }
      catch(_){
        emit(CartError());
      }
    }
  }


}
