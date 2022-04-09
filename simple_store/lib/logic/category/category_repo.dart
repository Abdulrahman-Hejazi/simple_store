



import 'package:simple_store/model/category.dart';
import 'package:simple_store/service/auth.dart';

class CategoryRepo{

  int? _selectedCategoryID ;
  List<Category> _categories = [];
  Auth _auth = Auth();

  getSelectedID()=> _selectedCategoryID;
  setSelectedID(int? id) => _selectedCategoryID = id;
  clearSelectedID() => _selectedCategoryID = null;



  loadCategories() async {
    _categories = await _auth.getAllCategories();
    return _categories;

  }



}