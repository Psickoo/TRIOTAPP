import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:loginpage/controller/maincontroller.dart';
import 'package:loginpage/controller/servo_layout.dart';
import 'package:loginpage/primary_color.dart/color.dart';

import '../hiddenDpages/setting_page.dart';
import '../hiddenDpages/stream.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'C O N T R O L ',
          baseStyle: TextStyle(
              color: Color.fromARGB(255, 218, 206, 206),
              fontWeight: FontWeight.bold),
          selectedStyle: TextStyle(),
          colorLineSelected: Color.fromARGB(255, 218, 206, 206),
        ),
        stream(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'L O G O U T',
          baseStyle: TextStyle(
              color: Color.fromARGB(255, 218, 206, 206),
              fontWeight: FontWeight.bold),
          selectedStyle: TextStyle(),
          colorLineSelected: Color.fromARGB(255, 218, 206, 206),
        ),
        Logout(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.grey[800]!,
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 30,
    );
  }
}
