import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:week4_flutter_app/screens/modal_todo.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';

class FriendDetailPage extends StatefulWidget {
  final Todo friend;

  FriendDetailPage({required this.friend, super.key});

  @override
  _FriendDetailPageState createState() => _FriendDetailPageState();
}

class _FriendDetailPageState extends State<FriendDetailPage> {
  Permission permission = Permission.camera;
  PermissionStatus permissionStatus = PermissionStatus.denied;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() async {
    final status = await permission.status;
    setState(() => permissionStatus = status);
  }

  Future<void> requestPermission() async {
    final status = await permission.request();
    setState(() {
      permissionStatus = status;
    });
  }

  Future<void> _takePicture() async {
    if (permissionStatus == PermissionStatus.granted) {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        imageFile = image == null ? null : File(image.path);
      });
    } else {
      requestPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.friend.name}'s Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: imageFile == null
                  ? CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      child:
                          Icon(Icons.person, size: 60, color: Colors.grey[700]),
                    )
                  : ClipOval(
                      child: Image.file(
                        imageFile!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            SizedBox(height: 20),
            Text("Name: ${widget.friend.name}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Nickname: ${widget.friend.nickname}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Age: ${widget.friend.age}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Motto: ${widget.friend.radioMotto}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Superpower: ${widget.friend.superpower}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Is Single: ${widget.friend.isSingle ? "Yes" : "No"}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Happiness Level: ${widget.friend.happinessLevel}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (BuildContext context) => TodoModal(
                      type: 'Edit',
                      item: widget.friend,
                    ),
                  );
                  if (result == true) {
                    context.read<TodoListProvider>().fetchTodos();
                  }
                },
                child: const Text("Edit Details"),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _takePicture,
                child: const Text("Take Picture"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
