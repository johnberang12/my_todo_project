import 'package:flutter/material.dart';
import 'package:todo_own_project/models/todo.dart';
import 'package:todo_own_project/services/todo_service.dart';

class TodosByCategory extends StatefulWidget {
  final String category;
  TodosByCategory({required this.category});


  @override
  _TodosByCategoryState createState() => _TodosByCategoryState();
}

class _TodosByCategoryState extends State<TodosByCategory> {
  List<Todo> _todoList = [];
  TodoService _todoService = TodoService();
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  initState(){
    super.initState();
    getTodoByCategory();
  }

  getTodoByCategory() async {
   var todos = await _todoService.todoByCategory(widget.category);
   todos.forEach((todo){
     setState(() {
       var model = Todo();
       model.title = todo['title'];
       _todoList.add(model);
     });
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos by category'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
          Text(capitalize(widget.category),
            style: TextStyle(
              fontSize: 20.0
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: _todoList.length,
                  itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_todoList[index].title),
                        ],
                      ),
                    ),
                  );


                  }
              )
          )
        ],
      ),
    );
  }
}
