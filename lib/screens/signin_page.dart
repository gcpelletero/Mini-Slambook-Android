import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  bool _isLoading = false;
  bool _passwordVisibility = false; //tracks password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //overall background
      resizeToAvoidBottomInset:
          false, //this prevents resizing when keyboard appears

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 600, //max width to control size of the form
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, //takes only the needed space
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          const Center(
                            child: Text(
                              "Login to your account",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 8),
                            child: Container(
                              width: double.infinity,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _email = value!;
                                },
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
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red, //error color
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red, //error color
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFF6F6F6),
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          64, 24, 24, 24),
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
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                          const Text(
                            "",
                            style: TextStyle(color: Color(0xFF10044c)),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 8),
                            child: Container(
                              width: double.infinity,
                              child: TextFormField(
                                autofocus: true,
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
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red, // error color
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red, // error color
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFF6F6F6),
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          64, 24, 24, 24),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Color(0xFF9B9B9C),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _passwordVisibility =
                                            !_passwordVisibility;
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
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _password = value!;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    String message = await context
                                        .read<UserAuthProvider>()
                                        .signIn(_email, _password);
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    if (message == 'Signed in') {
                                      Navigator.pushReplacementNamed(
                                          context, '/todo');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(message),
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 72),
                                  backgroundColor:
                                      Color(0xFF101444), //login button color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      letterSpacing: 0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpPage()),
                                      );
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(
                                            0xFF9D99F8), //color of the register button
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
