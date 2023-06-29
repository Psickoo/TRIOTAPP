import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RoundNeuButton extends StatefulWidget {
  final Widget child;
  final String rtdbKey;
  final dynamic rtdbValueOn;
  final dynamic rtdbValueOff;

  RoundNeuButton({
    required this.child,
    required this.rtdbKey,
    required this.rtdbValueOn,
    required this.rtdbValueOff,
  });

  @override
  State<RoundNeuButton> createState() => _RoundNeuButtonState();
}

class _RoundNeuButtonState extends State<RoundNeuButton> {
  bool isButtonPressed = false;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) {
        setState(() {
          isButtonPressed = true;
          print('Button Pressed');
          databaseRef.child(widget.rtdbKey).set(widget.rtdbValueOn);
        });
      },
      onLongPressEnd: (_) {
        setState(() {
          isButtonPressed = false;
          print('Button Released');
          databaseRef.child(widget.rtdbKey).set(widget.rtdbValueOff);
        });
      },
      child: Container(
        width: 80,
        height: 80,
        child: Center(
          child: widget.child,
        ),
        decoration: BoxDecoration(
          color: isButtonPressed ? Colors.grey[400] : Colors.grey[300],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
