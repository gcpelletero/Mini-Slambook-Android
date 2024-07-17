import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week4_flutter_app/screens/modal_todo.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';

class FriendDetailPage extends StatelessWidget {
  final Todo friend;

  FriendDetailPage({required this.friend, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${friend.name}'s Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${friend.name}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Nickname: ${friend.nickname}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Age: ${friend.age}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Motto: ${friend.radioMotto}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Superpower: ${friend.superpower}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Is Single: ${friend.isSingle ? "Yes" : "No"}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Happiness Level: ${friend.happinessLevel}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (BuildContext context) => TodoModal(
                      type: 'Edit',
                      item: friend,
                    ),
                  );
                  if (result == true) {
                    context.read<TodoListProvider>().fetchTodos();
                  }
                },
                child: const Text("Edit Details"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
