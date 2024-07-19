import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../api/firebase_todo_api.dart';
import '../models/todo_model.dart';

class TodoListProvider with ChangeNotifier {
  late Stream<QuerySnapshot> _todosStream;
  var firebaseService = FirebaseTodoAPI();

  TodoListProvider() {
    fetchTodos();
  }

  // getter
  Stream<QuerySnapshot> get todo => _todosStream;

  // TODO: get all todo items from Firestore
  void fetchTodos() {
    _todosStream = firebaseService.getAllTodos();
    notifyListeners();
  }

  // TODO: add todo item and store it in Firestore
  void addTodo(Todo item) {
    firebaseService.addTodo(item.toJson(item)).then((message) {
      print(message);
    });
    notifyListeners();
  }

  // TODO: edit a todo item and update it in Firestore
  void editTodo(Todo item) {
    firebaseService.editTodo(item).then((message) {
      print(message);
    });
    notifyListeners();
  }

  // TODO: delete a todo item and update it in Firestore
  Future<void> deleteTodo(Todo item) async {
    String message = await firebaseService.deleteTodo(item.id!);
    print(message);
    notifyListeners();
  }

  // TODO: modify a todo status and update it in Firestore
  void toggleStatus(Todo item, bool status) {
    firebaseService.toggleStatus(item.id!, status).then((message) {
      print(message);
    });
    notifyListeners();
  }
}
