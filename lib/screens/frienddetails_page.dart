import 'dart:io';
import 'dart:convert'; //FOR JSON ENCODING
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart'; //FOR QR GENERATION
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
import 'package:week4_flutter_app/screens/modal_todo.dart';

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
  String? imageUrl;
  bool _showQrCode = false; 

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
    _loadImageUrl();
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

  Future<void> _loadImageUrl() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('todos')
        .doc(widget.friend.id)
        .get();
    setState(() {
      imageUrl = doc['imageUrl'];
    });
  }

  Future<void> _takePicture() async {
    if (permissionStatus == PermissionStatus.granted) {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          imageFile = File(image.path);
        });
        await _uploadImage(imageFile!);
      }
    } else {
      requestPermission();
    }
  }

  Future<void> _chooseFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
      await _uploadImage(imageFile!);
    }
  }

  Future<void> _uploadImage(File image) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String fileName =
            '${widget.friend.name}_${DateTime.now().millisecondsSinceEpoch}.jpg';
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('profile_images/$fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask;
        String url = await taskSnapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = url;
        });
        await _saveImageUrl(url);
        print('Upload success, download URL: $url');
      } else {
        print('User not authenticated');
      }
    } catch (e) {
      print('Upload error: $e');
    }
  }

  Future<void> _saveImageUrl(String url) async {
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(widget.friend.id)
        .update({'imageUrl': url});
  }

  String _generateQrData() {
    final data = {
      'name': widget.friend.name,
      'nickname': widget.friend.nickname,
      'age': widget.friend.age,
      'radioMotto': widget.friend.radioMotto,
      'superpower': widget.friend.superpower,
      'isSingle': widget.friend.isSingle,
      'happinessLevel': widget.friend.happinessLevel,
      'imageUrl': widget.friend.imageUrl,
    };
    return jsonEncode(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.friend.name}'s Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: imageUrl == null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.person,
                            size: 60, color: Colors.grey[700]),
                      )
                    : ClipOval(
                        child: Image.network(
                          imageUrl!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              SizedBox(height: 20),
              Text("Name: ${widget.friend.name}",
                  style: TextStyle(fontSize: 18)),
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
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: _chooseFromGallery,
                  child: const Text("Choose from Gallery"),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showQrCode = !_showQrCode;
                    });
                  },
                  child:
                      Text(_showQrCode ? "Hide QR Code" : "Generate QR Code"),
                ),
              ),
              if (_showQrCode)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: QrImageView(
                      data: _generateQrData(),
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
