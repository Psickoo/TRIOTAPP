import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passToggle = true;
  final _formKey = GlobalKey<FormState>();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.gamepad_rounded,
                      color: Color.fromARGB(255, 218, 206, 206),
                      size: 140,
                    ),
                    const SizedBox(height: 30),
                    //hello again
                    const Text(
                      'Hello Again!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 218, 206, 206),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome back!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 218, 206, 206),
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 50),

                    //email textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'email',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                        validator: (value) {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_ `{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!);

                          if (value.isEmpty) {
                            return "enter Email address";
                          } else if (!emailValid) {
                            return "enter valid email address";
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 15),
                    //pasword textfield

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                          controller: _passwordController,
                          obscureText: passToggle,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.lightBlue),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Password',
                              fillColor: Colors.grey[200],
                              filled: true,
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    passToggle = !passToggle;
                                  });
                                },
                                child: Icon(passToggle
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "enter password";
                            } else if (_passwordController.text.length < 8) {
                              return "password must be at least 8 characters";
                            }
                          }),
                    ),

                    const SizedBox(height: 25),

                    //sign in button

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            signIn();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 218, 206, 206),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //not a member? register now

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Not a member? ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 218, 206, 206),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue[300],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
