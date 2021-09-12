

import 'package:todo_own_project/models/category.dart';
import 'package:todo_own_project/repositories/repository.dart';

class CategoryService {

  late Repository _repository;

  CategoryService(){
    _repository = Repository();
  }

  saveCategory(Category category) async {
    return await _repository.save('categories', category.categoryMap());
  }

  getCategories()async{
    return await _repository.getAll('categories');
  }

}