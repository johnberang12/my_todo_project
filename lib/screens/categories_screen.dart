

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_own_project/models/category.dart';
import 'package:todo_own_project/services/category_service.dart';

import 'home_screen.dart';

class CategoriesScreen extends StatefulWidget {

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController _categoryName = TextEditingController();
  TextEditingController _categoryDescription = TextEditingController();

  Category _category = Category();
  CategoryService _categoryService = CategoryService();

  List<Widget>_categoryList = [];

  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await _categoryService.getCategories();
     categories.forEach((category) {
       _categoryList.add(Card(child: ListTile(title: Text(category['name']),)));
     });

  }


  _showFormInDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: [
          TextButton(
              onPressed: (){

              },
              child: Text('Cancel')),
          TextButton(
              onPressed: () async {
                _category.name = _categoryName.text;
                _category.description = _categoryDescription.text;
                var result = await _categoryService.saveCategory(_category);
                print(result);
              },
              child: Text('Save')),
        ],
        title: Text('Category Form'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _categoryName,
                decoration: InputDecoration(
                    labelText: 'Category Name',
                    hintText: 'write category name'
                ),
              ),
              TextField(
                controller: _categoryDescription,
                decoration: InputDecoration(
                    labelText: 'Category description',
                    hintText: 'write category description'
                ),
              ),
            ],
          ),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
            onPressed: () { Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen()
        )); },
        child: Icon(Icons.arrow_back, color: Colors.white,)),
        title: Text('Jo Ber'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showFormInDialog(context);
      }, child: Icon(Icons.add),),
      body: Column(
        children: _categoryList,
      ),
    );
  }
}

