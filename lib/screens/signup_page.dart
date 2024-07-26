import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? username;
  String? email;
  String? password;
  List<String> contactNumbers = [];
  bool _passwordVisibility = false; //tracks password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading,
                  nameField,
                  usernameField,
                  emailField,
                  passwordField,
                  contactNumbersField,
                  submitButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(top: 100, bottom: 30),
        child: Center(
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      );

  Widget get nameField => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: TextFormField(
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
          onSaved: (value) => setState(() => name = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your name";
            }
            return null;
          },
        ),
      );

  Widget get usernameField => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: TextFormField(
          decoration: InputDecoration(
            isDense: true,
            labelText: 'Username',
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
          onSaved: (value) => setState(() => username = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your username";
            }
            return null;
          },
        ),
      );

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: TextFormField(
          decoration: InputDecoration(
            isDense: true,
            labelText: 'Email',
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
              Icons.email,
              color: Color(0xFF9B9B9C),
            ),
          ),
          style: const TextStyle(
            fontFamily: 'Lexend Deca',
            letterSpacing: 0,
          ),
          textAlign: TextAlign.start,
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid email format";
            }
            return null;
          },
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: TextFormField(
          obscureText: !_passwordVisibility,
          decoration: InputDecoration(
            isDense: true,
            labelText: 'Password',
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
              Icons.lock,
              color: Color(0xFF9B9B9C),
            ),
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  _passwordVisibility = !_passwordVisibility;
                });
              },
              focusNode: FocusNode(skipTraversal: true),
              child: Icon(
                _passwordVisibility
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: const Color(0xFF757575),
                size: 22,
              ),
            ),
          ),
          style: const TextStyle(
            fontFamily: 'Lexend Deca',
            letterSpacing: 0,
          ),
          textAlign: TextAlign.start,
          onSaved: (value) => setState(() => password = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid password";
            }
            return null;
          },
        ),
      );

  Widget get contactNumbersField => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Contact Numbers",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (var contact in contactNumbers)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(child: Text(contact)),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          contactNumbers.remove(contact);
                        });
                      },
                    ),
                  ],
                ),
              ),
            TextFormField(
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Add Contact',
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
                  Icons.phone,
                  color: Color(0xFF9B9B9C),
                ),
              ),
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    contactNumbers.add(value);
                  });
                }
              },
            ),
          ],
        ),
      );

  Widget get submitButton => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              await context
                  .read<UserAuthProvider>()
                  .signUp(name!, username!, email!, password!, contactNumbers);

              if (mounted) Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize:
                Size(MediaQuery.of(context).size.width, 60), //height of button
            backgroundColor: Color(0xFF101444), //color of signup button
            padding: const EdgeInsets.symmetric(horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontFamily: 'Lexend Deca',
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
}
