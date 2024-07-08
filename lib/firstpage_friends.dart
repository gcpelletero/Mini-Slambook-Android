import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  final List<String> formdata; //list to hold entries displayed in the list
  const FirstPage({Key? key, required this.formdata})
      : super(key: key); //constructor
  //create instance of firstpage widget
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController controller =
      TextEditingController(); //text input controller
  String?
      resultMessage; //state variable to store the result message from 2nd page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(), //DRAWER WIDGET
      appBar: AppBar(
        title: Text(
          "Friends", //appBar title
          style: TextStyle(color: Color(0xFFfff4fc)),
        ),
        backgroundColor: Color(0xFF10044c), //AppBar background color
        iconTheme: IconThemeData(color: Colors.white), //3 lines icon
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.formdata.length, //number of list items
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(widget.formdata[index]), //list item text
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(
                  Color(0xFF10044c)), //button text color
              backgroundColor: WidgetStateProperty.all<Color>(
                  Colors.white), //button background color
              overlayColor:
                  WidgetStateProperty.all<Color>(Colors.black.withOpacity(0.2)),
            ),
            onPressed: () async {
              final result = await Navigator.pushNamed(
                context,
                "/second", //navigates to second page
                arguments: controller.text, //pass text input as argument
              );

              setState(() {
                resultMessage = result as String?; //stores result message
                if (resultMessage != null) {
                  //add entry to list if result not null
                  widget.formdata.add(resultMessage!);
                }
              });
            },
            child: Text("Go to the second page"), //button to secondpage
          ),
        ],
      ),
    );
  }

//drawer widget for navigation menu
  Widget drawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              "Exercise 5: Menu, Routes, and Navigation",
              style: TextStyle(
                color: Color(0xFF10044c), //drawer header text
                fontSize: 18,
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFe8e4ec), // drawer header background color
            ),
          ),
          ListTile(
            title: Text(
              "Friends",
              style: TextStyle(
                color: Color(0xFF10044c), //drawer list tile text color
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/first");
            },
          ),
          ListTile(
            title: Text(
              "Slambook",
              style: TextStyle(
                color: Color(0xFF10044c), //drawer list tile text color
              ),
            ),
            onTap: () {
              Navigator.pop(context); //closes drawer
              Navigator.pushNamed(
                context,
                "/second", //navigates to the second page
                arguments: controller.text, //pass text input as argument
              );
            },
          ),
        ],
      ),
    );
  }
}
