import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/todo_provider.dart';
import 'screens/home_page.dart';
import 'screens/secondpage_slambook.dart';
import 'screens/todo_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => TodoListProvider())),
        ChangeNotifierProvider(create: ((context) => UserAuthProvider())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //root of application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slambook App', //application title
      initialRoute: '/', //initial route when the application starts
      routes: {
        '/': (context) => const HomePage(),
        '/todo': (context) => const TodoPage(),
        '/slambook': (context) => const SecondPage(),
      },
    );
  }
}
