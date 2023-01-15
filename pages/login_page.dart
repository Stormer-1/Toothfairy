import "package:flutter/material.dart";
import 'home_page.dart';

void main() {
  runApp(const MaterialApp(home: LoginPage()));
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  final _formKey = GlobalKey<FormState>();
  final nicknamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  // Loading circle

  get signIn => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.deepPurple[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30.0),
                const Padding(
                  padding: EdgeInsets.only(right: 320),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 100),

                // Nickname field (Containing only alphabet characters or underscore )

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    width: 400.0,
                    height: 450.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                        topRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 25),
                            TextFormField(
                              controller: nicknamecontroller,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"^[A-Za-z][A-Za-z0-9_]{7,29}$")
                                        .hasMatch(value)) {
                                  return "Enter only more than 7 alphabet characters or underscore";
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                ),
                                labelText: "Nickname",
                                labelStyle: TextStyle(
                                  color: Colors.black12,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),

                            // Password field (Between 3 to 9 symbols)

                            TextFormField(
                              controller: passwordcontroller,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"^[A-Za-z][A-Za-z0-9_!@#\$&*~]{3,9}$")
                                        .hasMatch(value)) {
                                  return "Password length is between 4-9 symbols";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: _isHidden,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isHidden = !_isHidden;
                                    });
                                  },
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                ),
                                labelText: "Password",
                                labelStyle: const TextStyle(
                                  color: Colors.black12,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),

                            // Sign in button

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 118,
                                  vertical: 20,
                                ),
                                backgroundColor: Colors.deepPurple[300],
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30.0),

                            // Terms and conditions

                            const Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Center(
                                child: Text(
                                  "Регистрируясь вы прининаете наши условия:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}

class Timer {}
