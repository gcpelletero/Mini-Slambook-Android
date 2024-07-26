import 'dart:io';
import 'dart:convert'; //for JSON encoding
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart'; //for QR generation
import 'package:week4_flutter_app/screens/todo_page.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
import 'modal_todo.dart';

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
  int _selectedIndex = 0;

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

  void _refreshPage() async {
    await _loadImageUrl();
    setState(() {}); //ensures UI updates
  }

  Future<void> _takePicture() async {
    if (permissionStatus == PermissionStatus.granted) {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          imageFile = File(image.path);
        });
        await _uploadImage(imageFile!);
        _refreshPage(); //refreshes after uploading image
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
      _refreshPage(); //refreshes after uploading image
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _takePicture();
      } else if (index == 1) {
        _chooseFromGallery();
      } else if (index == 2) {
        setState(() {
          _showQrCode = !_showQrCode;
        });
      } else if (index == 3) {
        showDialog(
          context: context,
          builder: (BuildContext context) => TodoModal(
            type: 'Edit',
            item: widget.friend,
          ),
        ).then((result) {
          if (result == true) {
            _refreshPage(); //refreshes to show updated image
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //COVER PHOTO SECTION
            Container(
              color: pastelBlue, //background color of the cover photo
              height: 200, //height of cover photo
              width: double.infinity, //full width of screen
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // AppBar
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: AppBar(
                      title: Text(
                        "${widget.friend.name}'s details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0, //remove shadow for seamless overlap
                    ),
                  ),
                  //PROFILE PICTURE
                  Positioned(
                    top: 130, //to overlap with the cover photo
                    left: MediaQuery.of(context).size.width / 2 -
                        80, //Center horizontally
                    child: Column(
                      children: [
                        Container(
                          width: 160, //width of the container
                          height: 160, //height of the container
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, //border color
                              width: 4, //border width
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 80, //radius
                            backgroundColor: Colors.white,
                            backgroundImage: imageUrl == null
                                ? null
                                : NetworkImage(imageUrl!),
                            child: imageUrl == null
                                ? Icon(Icons.person,
                                    size: 80, color: Colors.grey[700])
                                : null,
                          ),
                        ),
                        SizedBox(height: 8),
                        //NAME DISPLAY
                        Text(
                          widget.friend.name,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //MAIN CONTENT BELOW
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 120),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0), //top padding
                    child: Card(
                      elevation: 5,
                      child: Container(
                        width: 400,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'nickname: ',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${widget.friend.nickname}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                text: 'age: ',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${widget.friend.age}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                text: 'motto: ',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${widget.friend.radioMotto}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                text: 'superpower: ',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${widget.friend.superpower}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                text: 'single: ',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '${widget.friend.isSingle ? "Yes" : "No"}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                text: 'happiness level: ',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${widget.friend.happinessLevel}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_showQrCode) SizedBox(height: 20),
                  if (_showQrCode)
                    Center(
                      child: Card(
                        elevation: 5,
                        child: SizedBox(
                          width: 400, //fixed width for the QR code container
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: QrImageView(
                                data: _generateQrData(),
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Take Picture',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit Details',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFF101444), //color for selected item
        unselectedItemColor: Colors.grey, // color for unselected items
        backgroundColor: Colors.white, //cackground color of  bottom bar
      ),
    );
  }
}
