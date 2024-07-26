import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';
import '../providers/auth_provider.dart';
import '../providers/todo_provider.dart';
import 'frienddetails_page.dart';
import 'modal_todo.dart';
import 'secondpage_slambook.dart';

//pastel colors
const Color pastelPink = Color(0xFFFFC0CB);
const Color pastelBlue = Color(0xFFBFD3C1);
const Color pastelYellow = Color(0xFFFFF6C3);
const Color pastelYellow2 = Color.fromARGB(255, 252, 235, 141);
const Color pastelGreen = Color(0xFFB5EAD7);
const Color pastelPurple = Color(0xFFB6A0C6);

const Color button1 = Color(0xFFE7E5FD);
const Color button2 = Color(0xFFFFFEE3);
const Color button3 = Color(0xFFFAE2F1);

//text color
const Color textColor = Color(0xFF101444);

//list of colors for the containers
const List<Color> containerColors = [
  Color(0xFFE7E5FD),
  Color(0xFFFFFEE3),
  Color(0xFFFAE2F1),
  Color(0xFFF5D7D7),
  Color(0xFF9D99F8),
  Color(0xFFFDF2E2),
];

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoListProvider>().fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;
    UserAuthProvider authProvider = context.watch<UserAuthProvider>();
    String? nameofUser = authProvider.nameofUser;

    return Scaffold(
      drawer: _buildDrawer(nameofUser),
      body: Container(
        color: Colors.white, //default background of the screen
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: Text(
                  'Friends',
                  style: TextStyle(
                    fontFamily: 'Titan One',
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Builder(
                  builder: (context) {
                    return IconButton(
                      icon: Icon(Icons.menu, color: pastelBlue, size: 32),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
              ),
              backgroundColor: Colors.white, //background color of appbar
              elevation: 0,
              scrolledUnderElevation: 0.0,
              toolbarHeight: 80, //height of appbar
              titleSpacing: 0,
              centerTitle: true,
              floating: true,
              pinned: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 0.0),
              sliver: StreamBuilder(
                stream: todosStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          "Oops! Something went wrong: ${snapshot.error}",
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return SliverFillRemaining(
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.sentiment_dissatisfied,
                                size: 100, color: pastelPink),
                            const Text(
                              "No Friends Found",
                              style: TextStyle(
                                color: textColor,
                                fontSize: 24,
                                fontFamily: 'Comic Sans MS',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        Todo todo = Todo.fromJson(snapshot.data?.docs[index]
                            .data() as Map<String, dynamic>);
                        todo.id = snapshot.data?.docs[index].id;
                        //go through with the colors base on index for containers
                        Color containerColor =
                            containerColors[index % containerColors.length];
                        return Dismissible(
                          key: Key(todo.id.toString()),
                          onDismissed: (direction) {
                            context.read<TodoListProvider>().deleteTodo(todo);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('${todo.name} removed')));
                          },
                          background: Container(
                            color: Colors.red,
                            child: const Icon(Icons.delete),
                          ),
                          child: Card(
                            color: containerColor,
                            elevation: 0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 23),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16.0),
                              leading: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle,
                                  image: todo.imageUrl != null
                                      ? DecorationImage(
                                          image: NetworkImage(todo.imageUrl!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: todo.imageUrl == null
                                    ? Icon(Icons.person,
                                        size: 40, color: Colors.grey[700])
                                    : null,
                              ),
                              title: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FriendDetailPage(friend: todo),
                                    ),
                                  );
                                },
                                child: Text(
                                  todo.name,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 18,
                                    fontFamily: 'Comic Sans MS',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.delete, color: textColor),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            TodoModal(
                                          type: 'Delete',
                                          item: todo,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: snapshot.data?.docs.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer(String? name) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: pastelBlue,
          ),
          child: Text(
            name != null ? "Hello, $name!" : "Hello!",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'Comic Sans MS',
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.book, color: button1),
          title: Text('Slambook', style: TextStyle(color: textColor)),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/slambook');
          },
        ),
        ListTile(
          leading: Icon(Icons.people, color: button2),
          title: Text('Friends', style: TextStyle(color: textColor)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.logout, color: button3),
          title: Text('Logout', style: TextStyle(color: textColor)),
          onTap: () async {
            await context.read<UserAuthProvider>().signOut(context);
          },
        ),
      ]),
    );
  }
}
