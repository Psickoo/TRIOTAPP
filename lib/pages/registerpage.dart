import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  bool passToggle = true;
  bool confirmPassToggle = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
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
                    const SizedBox(height: 26),
                    //hello again
                    const Text(
                      'Hello There!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 218, 206, 206),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'register here to continue!',
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
                              return "password is password";
                            } else if (_passwordController.text.length < 8) {
                              return "password must be at least 8 characters";
                            }
                          }),
                    ),

                    const SizedBox(height: 15),
                    //confirm pasword textfield

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: confirmPassToggle,
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
                              hintText: 'confirm Password',
                              fillColor: Colors.grey[200],
                              filled: true,
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    confirmPassToggle = !confirmPassToggle;
                                  });
                                },
                                child: Icon(passToggle
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please re-enter password";
                            } else if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              return "passwords does not match";
                            }
                          }),
                    ),

                    const SizedBox(height: 21),

                    Center(
                      child: Text(
                        errorMessage,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    //sign in button

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            try {
                              signUp();
                              errorMessage = '';
                            } on FirebaseAuthException catch (error) {
                              errorMessage = error.message!;
                            }
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 218, 206, 206),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Text(
                              'Sign Up',
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
                          'Already a member? ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 218, 206, 206),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.showLoginPage,
                          child: Text(
                            'Login Now',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue[300],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Center(
                      child: Text(errorMessage),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
