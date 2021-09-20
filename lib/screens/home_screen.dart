

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_own_project/helpers/drawer_navigation.dart';
import 'package:todo_own_project/models/todo.dart';
import 'package:todo_own_project/screens/todo_screen.dart';
import 'package:todo_own_project/services/todo_service.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService _todoService = TodoService();
  List<Todo> _todoList = [];

  @override
  initState(){
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
     _todoList = [];
    var todos = await _todoService.getTodos();
    todos.forEach((todo){
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.todoDate = todo['todoDate'];
        model.isFinished = todo['isFinished'];
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Todo Version'),
      ),
      drawer: DrawerNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => TodoScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
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
            )
          );
          },),
    );
  }
}

