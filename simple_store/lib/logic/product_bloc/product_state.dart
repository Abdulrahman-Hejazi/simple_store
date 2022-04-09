part of 'product_bloc.dart';

abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductError extends ProductState {}

class ProductLoaded extends ProductState {
  ProductLoaded({required this.products});

  List<Product> products;

  @override
  List<Object> get prob => [products];
}
