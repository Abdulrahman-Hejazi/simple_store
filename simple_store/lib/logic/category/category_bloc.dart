import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:simple_store/model/category.dart';

import 'category_repo.dart';

part 'category_event.dart';

part 'categroy_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(this.categoryRepo) : super(CategoryLoading()) {
    on<CategoryStarted>(_onCategoryStarted);
    on<CategorySelected>(_onCategorySelected);
  }

  CategoryRepo categoryRepo;

  Future _onCategorySelected(
      CategorySelected event, Emitter<CategoryState> emit) async {
    final state = this.state;
    if (state is CategoryLoaded) {
      try {
        if (event.id != null) {
          categoryRepo.setSelectedID(event.id);
        } else {
          categoryRepo.clearSelectedID();
        }
        emit(CategoryLoaded(
            categories: state.categories,
            selectedCategory: categoryRepo.getSelectedID()));
      } catch (_) {
        emit(CategoryError());
      }
    }
  }

  Future _onCategoryStarted(
      CategoryStarted event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      List<Category> categories = await categoryRepo.loadCategories();

      emit(CategoryLoaded(categories: categories));
    } catch (_) {
      emit(CategoryError());
    }
  }
}
