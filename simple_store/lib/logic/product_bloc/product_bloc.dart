
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:simple_store/logic/product_bloc/product_repo.dart';
import 'package:simple_store/model/products.dart';




part 'product_event.dart';

part 'product_state.dart';


class ProductBloc extends Bloc<ProductEvent,ProductState>{
  ProductBloc(this.productRepo) : super(ProductLoading()){
    on<ProductStarted>(_onProductStarted);
    on<ProductReload>(_onProductReload);
  }



  ProductRepo productRepo;


  FutureOr<void> _onProductReload(ProductReload event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try{
      print('started ${event.selectedCategory}');
      if (event.selectedCategory != null) {
        print('in category');
        List<Product> products = await productRepo.loadProductsInCateggory(event.selectedCategory as int);
        print('products ready');
        emit(ProductLoaded(products: products));
      }
      else {
        print('load all');
        List<Product> products = await productRepo.loadProducts();
        emit(ProductLoaded(products: products));
      }

    }catch(e){
      print(e);
      emit(ProductError());
    }
  }

  FutureOr<void> _onProductStarted(ProductStarted event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try{
      List<Product> products = await productRepo.loadProducts();
      emit(ProductLoaded(products: products));
    }
    catch(_){
      emit(ProductError());
    }
  }


}