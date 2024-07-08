import 'package:flutter/material.dart';
import 'firstpage_friends.dart';
import 'secondpage_slambook.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //static list to store data from form
  static List<String> formdata = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slambook App', //application title
      initialRoute: '/first', //initial route when the application starts
      routes: {
        '/first': (context) =>
            FirstPage(formdata: formdata), //pass formdata to FirstPage
        '/second': (context) => SecondPage(
              text: ModalRoute.of(context)?.settings.arguments
                  as String?, //pass arguments to SecondPage
            ),
      },
    );
  }
}
