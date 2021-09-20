
class Todo {
   int? id;
  late String title;
  late String description;
  late String category;
  late String todoDate;
  late int isFinished;

  todoMap() {
    var map = Map<String, dynamic>();
    if(id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['todoDate'] = todoDate;
    map['isFinished'] = isFinished;

    return map;
  }
}