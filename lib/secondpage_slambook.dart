import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondPage extends StatelessWidget {
  final String? text;
  const SecondPage({this.text, super.key}); //constructor for SecondPage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Slambook",
          style: TextStyle(color: Color(0xFFfff4fc)), //title color
        ),
        backgroundColor: Color(0xFF10044c), //AppBar background color
        iconTheme: IconThemeData(color: Colors.white), //3 lines icon color
      ),
      drawer: drawer(context), //DRAWER WIDGET
      body: ListView(
        children: [
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
                      color: Color(0xFF10044c),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const FormSample(), //formsample widget
        ],
      ),
    );
  }

  Widget drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              "Exercise 5: Menu, Routes, and Navigation",
              style: TextStyle(
                color: Color(0xFF10044c), //drawer header text color
                fontSize: 18,
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFe8e4ec), //drawer header background color
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
              Navigator.pushNamed(context, "/first"); //navigation to 1st route
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
              Navigator.pop(context);
              Navigator.pushNamed(context, "/second",
                  arguments: text); //navigation to second route with arguments
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
  double happinessLevel = 0;
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
      radioMotto = null;
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formkey,
        child: Column(
          children: [
            //NAME
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFF10044c)), //border color here
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFF10044c)), //focused border color
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  border: const OutlineInputBorder(),
                  hintText: "Name",
                  labelText: "Name",
                ),
              ),
            ),
            //NICKNAME
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nicknameController,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a nickname";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFF10044c)), //border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFF10044c)), //focused border color
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  border: const OutlineInputBorder(),
                  hintText: "Nickname",
                  labelText: "Nickname",
                ),
              ),
            ),
            //AGE & STATUS
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: ageController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter an age";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF10044c)), //border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF10044c)), //focused border color
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(),
                        hintText: "Age",
                        labelText: "Age",
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
                    activeColor: Color(0xFF10044c), //active thumb color
                    activeTrackColor: Color(0xFFe8e4ec), //active track color
                  ),
                ],
              ),
            ),
            //HAPPINESS LEVEL
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
                        color: Color(0xFF10044c)),
                  ),
                  const Text(
                    "On a scale of 0 (Hopeless) to 10 (Very Happy), how would you rate your current lifestyle?",
                    textAlign: TextAlign.center,
                  ),
                  Slider(
                    value: happinessLevel,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: happinessLevel.toInt().toString(),
                    onChanged: (double value) {
                      setState(() {
                        happinessLevel = value;
                      });
                    },
                    activeColor: Color(0xFF10044c), //slider active color here
                  ),
                ],
              ),
            ),
            SizedBox(height: 10), //vertical space
            //SUPERPOWER
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    "Superpower",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10044c)),
                  ),
                  const Text(
                    "If you were to have a superpower, what would it be?",
                  ),
                  Container(
                    width: 450, //width of dropdown
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
            //MOTTO
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text("Motto",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF10044c))),
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
                            Color(0xFF10044c), //selected radio button color
                        controlAffinity: ListTileControlAffinity
                            .trailing, //align radio buttons to right
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            //SUBMIT & RESET BUTTON
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState?.save();
                        updatedSummary(); //update summary on submit
                        Navigator.pop(context, summaryText);
                      }
                    },
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(
                          Colors.white), //text color
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Color(0xFF10044c)), //background color
                      overlayColor: WidgetStateProperty.all<Color>(
                          Colors.black.withOpacity(0.2)), //splash color
                    ),
                    child: const Text("Submit"),
                  ),
                  OutlinedButton(
                    onPressed: resetForm,
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(
                          Color(0xFF10044c)), //text color
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

            //summary text
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
