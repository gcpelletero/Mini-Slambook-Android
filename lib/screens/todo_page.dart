import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';
import '../providers/auth_provider.dart';
import '../providers/todo_provider.dart';
import 'frienddetails_page.dart';
import 'modal_todo.dart';
import 'secondpage_slambook.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  //ensures data refresh by calling fetchtodos in initstate
  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback -- schedules the fetchTodos() method to be called after the current build phase is complete
    //ensures that the state is not being updated during the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoListProvider>().fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: const Text(
          "Friends", style: TextStyle(color: Color(0xFFfff4fc)), //title color
        ), //appbar upper text title
        backgroundColor: Color(0xFF10044c), //AppBar background color
        iconTheme: IconThemeData(color: Colors.white), //3 lines icon color
      ),
      //streambuilder - widget that responds to changes
      body: StreamBuilder(
        stream: todosStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No Friends Found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: ((context, index) {
              Todo todo = Todo.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>);
              todo.id = snapshot.data?.docs[index].id;
              return Dismissible(
                key: Key(todo.id.toString()),
                onDismissed: (direction) {
                  context.read<TodoListProvider>().deleteTodo(todo);

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${todo.name} dismissed')));
                },
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                child: ListTile(
                  title: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FriendDetailPage(friend: todo),
                        ),
                      );
                    },
                    child: Text(
                      todo.name,
                      style: const TextStyle(
                          color: Color(0xFF10044c)), // Change the color here
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => TodoModal(
                              type: 'Delete',
                              item: todo,
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete_outlined),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }

/////////////////////DRAWER PART///////////////////////

  Drawer get drawer => Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(
            child: Text(
          "Exercise 7: Data Persistence using Firebase",
          style: TextStyle(
            color: Color(0xFF10044c), //drawer header text color
            fontSize: 18,
          ),
        )),
        ListTile(
          title: const Text('Slambook'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SecondPage()));
          },
        ),
        ListTile(
          title: const Text('Friends'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          title: const Text('Logout'),
          onTap: () async {
            await context.read<UserAuthProvider>().signOut();
            Navigator.pushReplacementNamed(
                context, '/login'); // Navigate to login page
          },
        ),
      ]));
}
