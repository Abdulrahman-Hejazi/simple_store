part of 'cart_bloc.dart';



@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartStarted extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartItemAdded extends CartEvent {
  const CartItemAdded(this.item);

  final CartItem item;

  @override
  List<Object> get props => [item];
}

class CartItemRemoved extends CartEvent {
  const CartItemRemoved(this.item);

  final CartItem item;

  @override
  List<Object> get props => [item];
}

class CartItemModified extends CartEvent{
  final Product item;
  final int newQuantity;

  const CartItemModified(this.item, this.newQuantity);

  @override
  List<Object> get props => [item];

}

class CartClear extends CartEvent{


  @override
  List<Object?> get props => [];

}