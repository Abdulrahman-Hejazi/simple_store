part of 'product_bloc.dart';


abstract class ProductEvent{}

class ProductStarted extends ProductEvent{

}

class ProductReload extends ProductEvent{
  int? selectedCategory;

  ProductReload(this.selectedCategory);
}

