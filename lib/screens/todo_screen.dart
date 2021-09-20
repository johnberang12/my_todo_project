import 'package:flutter/material.dart';
import 'package:todo_own_project/models/todo.dart';
import 'package:todo_own_project/services/category_service.dart';
import 'package:intl/intl.dart';
import 'package:todo_own_project/services/todo_service.dart';


class TodoScreen extends StatefulWidget {


  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController _todoTitle = TextEditingController();
  TextEditingController _todoDescription = TextEditingController();
  TextEditingController _todoDate = TextEditingController();

  var _selectedValue;

   List<DropdownMenuItem> _categories = [];

   @override
   void initState(){
     super.initState();
     _loadCategories();
   }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   _loadCategories() async{
     var _categoryService = CategoryService();
     var categories = await _categoryService.getCategories();
     categories.forEach((category){
       setState(() {
         _categories.add(DropdownMenuItem(child: Text(category['name']), value: category['name'],));
       });
     });
   }

   DateTime _date = DateTime.now();

   _selectTodoDate(BuildContext context) async {
     var _pickedDate = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2000), lastDate: DateTime(2099));
     if(_pickedDate != null){
       setState(() {
         _date = _pickedDate;
         _todoDate.text = DateFormat('yyyy-mm-dd').format(_pickedDate);
       });
     }
   }

  _showSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    _scaffoldKey.currentState!.showSnackBar(_snackBar);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Create Todo'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    TextField(
                      controller: _todoTitle,
                      decoration: InputDecoration(
                        hintText: 'Todo title',
                        labelText: 'Cook food'
                      ),
                    ),
                    TextField(
                      controller: _todoDescription,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Todo description',
                        labelText: 'Cook rice and curry',
                      ),

                    ),
                    TextField(
                      controller: _todoDate,
                      decoration: InputDecoration(
                        hintText: 'YY-MM-DD',
                        labelText: 'YY-MM-DD',
                        prefixIcon: InkWell(
                            child: Icon(Icons.calendar_today),
                          onTap: (){
                              _selectTodoDate(context);
                          },
                        ),
                      ),
                    ),

                    DropdownButtonFormField<dynamic>(
                          items: _categories,
                        value: _selectedValue,
                        hint: Text('Select one category'),
                        onChanged: (newValue){
                            _selectedValue = newValue;

                        },

                      ),
                    ElevatedButton(
                        onPressed: ()async{
                          var todoObj = Todo();
                          todoObj.title = _todoTitle.text;
                          todoObj.description = _todoDescription.text;
                          todoObj.todoDate = _todoDate.text;
                          todoObj.category = _selectedValue.toString();
                          todoObj.isFinished = 0;
                          var _todoService = TodoService();
                          var result = await _todoService.insertTodo(todoObj);
                          if(result > 0){
                            _showSnackBar(Text('Success'));
                            _loadCategories();
                            Navigator.pop(context);
                          } else {
                            _showSnackBar(Text('Failed'));

                          }
                        },
                        child: Text('Save'),
                    ),
                  ],
                ),
            ),
          ),
      );
  }

}

