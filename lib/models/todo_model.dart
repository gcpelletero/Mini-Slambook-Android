import 'dart:convert';

class Todo {
  String? id;
  String name;
  String nickname;
  int age;
  bool isSingle;
  int happinessLevel;
  String radioMotto;
  String superpower;
  String? imageUrl;
  bool verified;

  Todo({
    this.id,
    required this.name,
    required this.nickname,
    required this.age,
    required this.isSingle,
    required this.happinessLevel,
    required this.radioMotto,
    required this.superpower,
    this.imageUrl,
    this.verified = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      name: json['name'],
      nickname: json['nickname'],
      age: json['age'],
      isSingle: json['isSingle'],
      happinessLevel: json['happinessLevel'],
      radioMotto: json['radioMotto'],
      superpower: json['superpower'],
      imageUrl: json['imageUrl'],
      verified: json['verified'] ?? false,
    );
  }

  static List<Todo> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Todo>((dynamic d) => Todo.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Todo todo) {
    return {
      'id': todo.id,
      'name': todo.name,
      'nickname': todo.nickname,
      'age': todo.age,
      'isSingle': todo.isSingle,
      'happinessLevel': todo.happinessLevel,
      'radioMotto': todo.radioMotto,
      'superpower': todo.superpower,
      'imageUrl': todo.imageUrl,
      'verified': todo.verified,
    };
  }
}
