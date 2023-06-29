import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:loginpage/controller/maincontroller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ServoLayout());
}

class ServoLayout extends StatefulWidget {
  @override
  _ServoLayoutState createState() => _ServoLayoutState();
}

class _ServoLayoutState extends State<ServoLayout> {
  double servo1 = 0.0;

  @override
  void initState() {
    super.initState();
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child('servo1').once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        double initialValue = double.parse(snapshot.value.toString());
        setState(() {
          servo1 = initialValue;
        });
      }
    }, onError: (error) {
      // Handle the error, if needed
      print('Error retrieving servo1 value: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        // child: Padding(
        //   padding: const EdgeInsets.only(top: 1.0),
        child: Column(
          children: [
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                color: Colors.grey[300],
                child: Column(
                  children: [
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey[300]!,
                            Colors.grey[300]!,
                            Colors.grey[300]!,
                          ],
                        ),
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
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'H O R I Z O N T A L',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500],
                              ),
                            ),
                            SizedBox(
                              width: 300.0, // Adjust the width as needed
                              child: Slider(
                                value: servo1,
                                min: 0,
                                max: 180,
                                divisions: 180,
                                label: servo1.round().toString(),
                                thumbColor: Colors.grey[700],
                                activeColor: Colors.grey[100],
                                inactiveColor: Colors.grey[600],
                                onChanged: (double value) {
                                  setState(() {
                                    servo1 = value;
                                  });
                                  DatabaseReference databaseReference =
                                      FirebaseDatabase.instance.reference();
                                  databaseReference
                                      .child('servo1')
                                      .set(value.round());
                                },
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
            SizedBox(height: 16.0),
            Expanded(
              child: MainController(),
            ),
          ],
        ),
        // ),
      ),
    );
  }
}
