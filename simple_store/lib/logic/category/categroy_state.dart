part of 'category_bloc.dart';


abstract class CategoryState{}


class CategoryLoading extends CategoryState{}

class CategoryError extends CategoryState{
}


class CategoryLoaded extends CategoryState{
  CategoryLoaded({required this.categories,this.selectedCategory});
  int? selectedCategory;
  List<Category> categories;
}