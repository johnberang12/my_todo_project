
import 'package:todo_own_project/models/category.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  List<Category> _categoryList = [];

  var _editCategoryName = TextEditingController();

  var _editCategoryDescription = TextEditingController();

  var category;

  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
     _categoryList = [];
    var categories = await _categoryService.getCategories();
     categories.forEach((_category) {
       setState(() {
         var model = Category();
         model.name = _category['name'];
         model.id = _category['id'];
         model.description = _category['description'];
         _categoryList.add(model);
       });

     });

  }


  _showFormInDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Cancel')),
          TextButton(
              onPressed: () async {

                  _category.name = _categoryName.text;
                  _category.description = _categoryDescription.text;
                  var result = await _categoryService.saveCategory(_category);
                  if(result > 0) {
                    Navigator.pop(context);
                  }
                  print(result);



      },


              child: Text('Add')),
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

  _editCategoryDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Cancel')),
          TextButton(
              onPressed: () async {
                  _category.id = category[0]['id'];
                  _category.name = _editCategoryName.text;
                  _category.description = _editCategoryDescription.text;
                  var result = await _categoryService.updateCategory(_category);
                  if(result > 0) {
                    Navigator.pop(context);
                    getAllCategories();
                  }
                  print(result);


              },
              child: Text('Update')),
        ],
        title: Text('Category Edit Form'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _editCategoryName,
                decoration: InputDecoration(
                    labelText: 'Category Name',
                    hintText: 'write category name'
                ),
              ),
              TextField(
                controller: _editCategoryDescription,
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

  _editCategory(BuildContext context, categoryId) async {
     category = await _categoryService.getCategoryById(categoryId);
    setState(() {
      _editCategoryName.text = category[0]['name'];
      _editCategoryDescription.text = category[0]['description'];
    });
    _editCategoryDialog(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jo Ber'),
        leading: ElevatedButton(
            onPressed: () { Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen()
        )); },
        child: Icon(Icons.arrow_back, color: Colors.white,)),

      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showFormInDialog(context);
      },
        child: Icon(Icons.add),),
      body:  ListView.builder(itemCount: _categoryList.length, itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){
                _editCategory(context, _categoryList[index].id);
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_categoryList[index].name!),

                IconButton(onPressed: (){}, icon: Icon(Icons.delete))
              ],
            ),
          ),
        );
      }),

    );
  }

}

