
import 'package:todo_own_project/models/todo.dart';
import 'package:todo_own_project/repositories/repository.dart';

class TodoService {
   Repository _repository = Repository();

  
  insertTodo(Todo todo) async {
    return await _repository.save('todos', todo.todoMap());
  }

  getTodos() async {
    return await _repository.getAll('todos');
  }

  todoByCategory(String category) async{
     return await _repository.getByColumnName('todos', 'category', category);
  }

}