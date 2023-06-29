import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.2, 0.5, 0.8, 0.7],
            colors: [
              Colors.grey[900]!,
              Colors.grey[800]!,
              Colors.grey[700]!,
              Colors.grey[600]!,
            ],
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              // Add your log out logic here
            },
            child: Text(
              'L O G O U T',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ),
      ),
    );
  }
}
