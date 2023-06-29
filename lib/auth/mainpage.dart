import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../controller/maincontroller.dart';
import '../pages/homepage.dart';
import '../pages/loginpage.dart';
import 'authpage.dart';
import '../hiddenDpages/setting_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return HiddenDrawer();
          }

          // user is NOT logged in
          else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
