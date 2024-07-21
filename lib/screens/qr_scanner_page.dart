import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
import 'package:provider/provider.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      await controller.pauseCamera();
      try {
        if (scanData.code != null) {
          final data = jsonDecode(scanData.code!);
          final Todo newFriend = Todo(
            name: data['name'],
            nickname: data['nickname'],
            age: data['age'],
            radioMotto: data['radioMotto'],
            superpower: data['superpower'],
            isSingle: data['isSingle'],
            happinessLevel: data['happinessLevel'],
            imageUrl: data['imageUrl'],
          );

          context.read<TodoListProvider>().addTodo(newFriend);

          await FirebaseFirestore.instance.collection('todos').add({
            'name': newFriend.name,
            'nickname': newFriend.nickname,
            'age': newFriend.age,
            'radioMotto': newFriend.radioMotto,
            'superpower': newFriend.superpower,
            'isSingle': newFriend.isSingle,
            'happinessLevel': newFriend.happinessLevel,
            'imageUrl': newFriend.imageUrl,
          });

          Navigator.pop(context);
        } else {
          print('Scanned QR code is null');
        }
      } catch (e) {
        print('Error decoding QR code: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan QR Code')),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }
}
