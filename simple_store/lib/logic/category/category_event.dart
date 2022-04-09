part of 'category_bloc.dart';


abstract class CategoryEvent{}

class CategoryStarted extends CategoryEvent{

}

class CategorySelected extends CategoryEvent{
  int? id;

  CategorySelected(this.id);
}


