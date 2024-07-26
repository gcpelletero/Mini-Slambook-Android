import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:week4_flutter_app/screens/todo_page.dart';
import '../models/todo_model.dart';
import '../providers/auth_provider.dart';
import '../providers/todo_provider.dart';
import 'qr_scanner_page.dart';

class SecondPage extends StatelessWidget {
  final String? text;
  const SecondPage({this.text, super.key}); //constructor for SecondPage

  @override
  Widget build(BuildContext context) {
    UserAuthProvider authProvider = context.watch<UserAuthProvider>();
    String? nameofUser = authProvider.nameofUser;

    return Scaffold(
      drawer: drawer(context, nameofUser), //drawer widget
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 17.0),
              child: Text(
                'Slambook',
                style: TextStyle(
                  fontFamily: 'Titan One',
                  color: Colors.white,
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
                    icon: Icon(Icons.menu, color: Colors.white, size: 32),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
            ),
            backgroundColor: Color(0xFF101444), //background color of appbar
            elevation: 0,
            scrolledUnderElevation: 0.0,
            toolbarHeight: 70, //height of appbar
            titleSpacing: 0,
            centerTitle: true,
            floating: true,
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 0.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "My Friend's Slambook",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF101444),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const FormSample(), // FormSample widget
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QRScannerPage()),
          );
        },
        child: Icon(Icons.qr_code_scanner),
        backgroundColor: Color(0xFF101444),
      ),
    );
  }

  Widget drawer(BuildContext context, String? nameofUser) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: pastelBlue, //background of the header, upper part
            ),
            child: Text(
              nameofUser != null ? "Hello, $nameofUser!" : "Hello!",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'Comic Sans MS',
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.book, color: button1), //slambook icon
            title: Text('Slambook', style: TextStyle(color: textColor)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.people, color: button2),
            title: Text('Friends', style: TextStyle(color: textColor)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/todo');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: button3),
            title: Text('Logout', style: TextStyle(color: textColor)),
            onTap: () async {
              await context.read<UserAuthProvider>().signOut(context);
            },
          ),
        ],
      ),
    );
  }
}

class FormSample extends StatefulWidget {
  const FormSample({Key? key}) : super(key: key);

  @override
  _FormSampleState createState() => _FormSampleState();
}

class _FormSampleState extends State<FormSample> {
  String? name;
  String? nickname;
  bool isSingle = false;
  int happinessLevel = 0;
  String? radioMotto;

  String summaryText = ''; //holds the summary text

  final List<String> _motto = [
    "Haters gonna hate",
    "Bakers gonna bake",
    "If cannot be, borrow one from three",
    "Less is more, more or less",
    "Better late than sorry",
    "Don't talk to strangers when your mouth is full",
    "Let's burn the bridge when we get there"
  ];

  final List<String> dropdownOptions = [
    "Makalipad",
    "Maging Invisible",
    "Mapaibig siya",
    "Mapabago ang isip niya",
    "Mapalimot siya",
    "Mabalik ang nakaraan",
    "Mapaghiwalay sila",
    "Makarma siya",
    "Mapasagasaan siya sa pison",
    "Mapaitim ang tuhod ng iniibig niya"
  ];
  String dropdownvalue = "Makalipad";
  TextEditingController nameController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //initial value for radiomotto
    radioMotto = _motto.isNotEmpty ? _motto.first : null;
  }

  @override
  void dispose() {
    nameController.dispose();
    nicknameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void resetForm() {
    setState(() {
      formkey.currentState?.reset();
      nameController.clear();
      nicknameController.clear();
      ageController.clear();
      isSingle = false;
      happinessLevel = 0;
      radioMotto = _motto.isNotEmpty ? _motto.first : null;
      dropdownvalue = "Makalipad";
      summaryText = ''; //clears summary text on reset
    });
  }

  void updatedSummary() {
    setState(() {
      summaryText = '''
        Name: ${nameController.text}
        Nickname: ${nicknameController.text}
        Age: ${ageController.text}
        Single: ${isSingle ? 'Yes' : 'No'}
        Happiness Level: ${happinessLevel.toInt()}
        Superpower: $dropdownvalue
        Motto: ${radioMotto ?? 'Not selected'}
      ''';
    });
  }

  //savetofirestore method - creates a todo object from the form fields and save it to firestore
  void saveToFirestore() {
    if (formkey.currentState!.validate()) {
      formkey.currentState?.save();
      Todo newTodo = Todo(
        name: nameController.text,
        nickname: nicknameController.text,
        age: int.parse(ageController.text),
        isSingle: isSingle,
        happinessLevel: happinessLevel,
        radioMotto: radioMotto ?? '',
        superpower: dropdownvalue,
      );
      context.read<TodoListProvider>().addTodo(newTodo);
      resetForm();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                width: 350, //width of name input field
                child: TextFormField(
                  controller: nameController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Name',
                    labelStyle: const TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xD157636C),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00E0E3E7),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF6F6F6),
                    contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color(0xFF9B9B9C),
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Lexend Deca',
                    letterSpacing: 0,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            // NICKNAME
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Container(
                width: 350, //width of nickname input field
                child: TextFormField(
                  controller: nicknameController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter a nickname";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Nickname',
                    labelStyle: const TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xD157636C),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00E0E3E7),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF6F6F6),
                    contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color(0xFF9B9B9C),
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Lexend Deca',
                    letterSpacing: 0,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            // AGE & STATUS
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SizedBox(
                    width: 150, // width of age text input
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0, left: 8),
                      child: TextFormField(
                        controller: ageController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter an age";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Age',
                          labelStyle: const TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xD157636C),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00E0E3E7),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF6F6F6),
                          contentPadding: const EdgeInsetsDirectional.fromSTEB(
                              32, 16, 16, 16),
                          prefixIcon: const Icon(
                            Icons.cake,
                            color: Color(0xFF9B9B9C),
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          letterSpacing: 0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text("Are you single?"),
                  Switch(
                    value: isSingle,
                    onChanged: (value) {
                      setState(() {
                        isSingle = value;
                      });
                    },
                    activeColor: Color(0xFF101444), // active thumb color
                    activeTrackColor: Color(0xFFe8e4ec), // active track color
                  ),
                ],
              ),
            ),

            // HAPPINESS LEVEL
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 20), //vertical space

                  Text(
                    "Happiness Level:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF101444)),
                  ),
                  const Text(
                    "On a scale of 0 (Hopeless) to 10 (Very Happy), how would you rate your current lifestyle?",
                    textAlign: TextAlign.center,
                  ),
                  Slider(
                    value: happinessLevel.toDouble(),
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: happinessLevel.toInt().toString(),
                    onChanged: (double value) {
                      setState(() {
                        happinessLevel = value.toInt();
                      });
                    },
                    activeColor: Color(0xFF101444), //slider active color here
                  ),
                ],
              ),
            ),
            SizedBox(height: 10), //vertical space
            // SUPERPOWER
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    "Superpower",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF101444)),
                  ),
                  const Text(
                    "If you were to have a superpower, what would it be?",
                  ),
                  Container(
                    width: 350, //width of dropdown
                    child: DropdownButtonFormField(
                      value: dropdownvalue,
                      items: dropdownOptions.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownvalue = value.toString();
                        });
                        print(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30), //vertical space
            // MOTTO
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text("Motto",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF101444))),
                  Column(
                    children: _motto.map((String motto) {
                      return RadioListTile<String>(
                        title: Text(motto),
                        value: motto,
                        groupValue: radioMotto,
                        onChanged: (String? value) {
                          setState(() {
                            radioMotto = value;
                          });
                        },
                        activeColor:
                            Color(0xFF101444), //selected radio button color
                        controlAffinity: ListTileControlAffinity
                            .trailing, //align radio buttons to right
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // SUBMIT & RESET BUTTON
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: saveToFirestore,
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(
                          Colors.white), //text color
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Color(0xFF101444)), //background color
                      overlayColor: WidgetStateProperty.all<Color>(
                          Colors.black.withOpacity(0.2)), //splash color
                    ),
                    child: const Text("Submit"),
                  ),
                  OutlinedButton(
                    onPressed: resetForm,
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(
                          Color(0xFF10044c)), // Text color
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.white), //background color
                      overlayColor: WidgetStateProperty.all<Color>(
                          Colors.black.withOpacity(0.2)), //splash color
                    ),
                    child: const Text("Reset"),
                  ),
                ],
              ),
            ),

            // Summary text
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(summaryText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
