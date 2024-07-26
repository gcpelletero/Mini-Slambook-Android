import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';

class TodoModal extends StatefulWidget {
  final String type;
  final Todo? item;

  TodoModal({super.key, required this.type, required this.item});

  @override
  _TodoModalState createState() => _TodoModalState();
}

class _TodoModalState extends State<TodoModal> {
  late TextEditingController nameController;
  late TextEditingController nicknameController;
  late TextEditingController ageController;
  late TextEditingController mottoController;
  String dropdownValue = "Makalipad";
  bool isSingle = false;
  int happinessLevel = 0;
  String? radioMotto;

  final List<String> _motto = [
    "Haters gonna hate",
    "Bakers gonna bake",
    "If cannot be, borrow one from three",
    "Less is more, more or less",
    "Better late than sorry",
    "Don't talk to strangers when your mouth is full",
    "Let's burn the bridge when we get there"
  ];

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    nicknameController = TextEditingController();
    ageController = TextEditingController();
    mottoController = TextEditingController();

    if (widget.type == 'Edit' && widget.item != null) {
      nameController.text = widget.item!.name;
      nicknameController.text = widget.item!.nickname;
      ageController.text = widget.item!.age.toString();
      mottoController.text = widget.item!.radioMotto;
      dropdownValue = widget.item!.superpower;
      isSingle = widget.item!.isSingle;
      happinessLevel = widget.item!.happinessLevel
          .clamp(0, 10); //for value to be within range
      radioMotto = widget.item!.radioMotto;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    nicknameController.dispose();
    ageController.dispose();
    mottoController.dispose();
    super.dispose();
  }

  Text _buildTitle() {
    switch (widget.type) {
      case 'Add':
        return const Text("Add new todo");
      case 'Edit':
        return const Text("Edit Details");
      case 'Delete':
        return const Text("Delete");
      default:
        return const Text("");
    }
  }

  Widget _buildContent(BuildContext context) {
    switch (widget.type) {
      case 'Delete':
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure you want to delete '${widget.item!.name}'?",
            ),
          ],
        );
      default:
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                cursorColor: Colors.black, //cursor color
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.black), //text color
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), //border color
                  ),
                ),
                readOnly: widget.type == 'Edit', //name will be non-editable
              ),
              TextField(
                controller: nicknameController,
                cursorColor: Colors.black, //cursor color
                decoration: InputDecoration(
                  labelText: "Nickname",
                  labelStyle: TextStyle(color: Colors.black), //text color
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), //border color
                  ),
                ),
              ),
              TextField(
                controller: ageController,
                cursorColor: Colors.black, // age cursor color
                decoration: InputDecoration(
                  labelText: "Age",
                  labelStyle: TextStyle(color: Colors.black), //age text color
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black), //age border color
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              Container(
                width: double
                    .infinity, //dropdown button will use full width available to avoid going over the pixels
                child: DropdownButtonFormField<String>(
                  value: dropdownValue,
                  items: [
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
                  ].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Superpower",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  isExpanded: true,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Motto:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
                    activeColor: Colors.black,
                    controlAffinity: ListTileControlAffinity.trailing,
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              Text(
                "Status",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Are you Single?"),
                  Switch(
                    value: isSingle,
                    onChanged: (value) {
                      setState(() {
                        isSingle = value;
                      });
                    },
                    activeColor: Colors.black, // Active thumb color
                    activeTrackColor: Color(0xFFe8e4ec), // Active track color
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "Happiness Level",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Slider(
                value: happinessLevel.toDouble(),
                min: 0,
                max: 10,
                divisions: 10,
                label: happinessLevel.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    happinessLevel = value.toInt();
                  });
                },
                activeColor: Colors.black,
              ),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildTitle(),
      content: _buildContent(context),
      actions: [
        if (widget.type == 'Delete')
          TextButton(
            onPressed: () {
              context.read<TodoListProvider>().deleteTodo(widget.item!);
              Navigator.pop(context, true); //indicates deletion
            },
            child: const Text("Delete"),
          ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
          ),
        ),
        if (widget.type != 'Delete')
          TextButton(
            onPressed: () {
              if (widget.type == 'Add') {
                Todo newTodo = Todo(
                  name: nameController.text,
                  nickname: nicknameController.text,
                  age: int.parse(ageController.text),
                  isSingle: isSingle,
                  happinessLevel: happinessLevel,
                  radioMotto: radioMotto ?? '',
                  superpower: dropdownValue,
                  imageUrl:
                      widget.item?.imageUrl ?? '', //ensures image url is set
                );
                context.read<TodoListProvider>().addTodo(newTodo);
              } else if (widget.type == 'Edit' && widget.item != null) {
                Todo updatedTodo = Todo(
                  id: widget.item!.id,
                  name: widget.item!.name, //wont edit the name
                  nickname: nicknameController.text,
                  age: int.parse(ageController.text),
                  isSingle: isSingle,
                  happinessLevel: happinessLevel,
                  radioMotto: radioMotto ?? '',
                  superpower: dropdownValue,
                  imageUrl: widget.item!.imageUrl, //imageUrl is preserved
                );
                context.read<TodoListProvider>().editTodo(updatedTodo);
              }
              Navigator.pop(context, true); //update indication
            },
            child: const Text("Save"),
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
          ),
      ],
    );
  }
}
