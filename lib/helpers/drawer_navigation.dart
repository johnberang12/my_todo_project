
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_own_project/screens/categories_screen.dart';
import 'package:todo_own_project/screens/home_screen.dart';
import 'package:todo_own_project/services/category_service.dart';

class DrawerNavigation extends StatefulWidget {


  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {

  // CategoryService _categoryService = CategoryService();
  //
  // List<Widget>_categoryList = [];

  // @override
  // void initState(){
  //   super.initState();
  //   getAllCategories();
  // }
  //
  // getAllCategories() async {
  //   var categories = await _categoryService.getCategories();
  //   categories.forEach((category) {
  //     _categoryList.add(Card(child: ListTile(title: Text(category['name']),)));
  //
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text('Jo Ber'),
                accountEmail: Text('Category & Priority based on todo app'),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Icon(Icons.filter_list, color: Colors.white,),
                  ),
                ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              title: Text('Categories'),
              leading: Icon(Icons.view_list),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CategoriesScreen()));
              },
            ),
            // Column(children: _categoryList,)
          ],
        )
      ),
    );
  }
}
