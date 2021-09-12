class Category{
  late int id;
  late String name;
  late String description;

  categoryMap(){
    var map = Map<String, dynamic>();
    map['id'] = Map.identity();
    map['name'] = name;
    map['description'] = description;
    return map;
  }
}