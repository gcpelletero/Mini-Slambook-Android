import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todo_model.dart';

class FirebaseTodoAPI {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  //allows editTodo in FirebaseTodoAPI to accept a Todo object instead of string
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('todos');

  Stream<QuerySnapshot> getAllTodos() {
    return db.collection("todos").snapshots();
  }

  Future<String> addTodo(Map<String, dynamic> todo) async {
    try {
      await db.collection("todos").add(todo);

      return "Successfully added todo!";
    } on FirebaseException catch (e) {
      return "Failed with error ${e.code}";
    }
  }

  Future<String> deleteTodo(String id) async {
    try {
      await db.collection("todos").doc(id).delete();

      return "Successfully deleted todo!";
    } on FirebaseException catch (e) {
      return "Failed with error ${e.code}";
    }
  }

  Future<String> editTodo(Todo todo) async {
    try {
      await collection.doc(todo.id).update(todo.toJson(todo));
      return 'Todo updated successfully';
    } catch (e) {
      return 'Error updating todo: $e';
    }
  }

  Future<String> toggleStatus(String id, bool newValue) async {
    try {
      await db.collection("todos").doc(id).update({"completed": newValue});

      return "Successfully toggled todo!";
    } on FirebaseException catch (e) {
      return "Failed with error ${e.code}";
    }
  }
}
