import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';
import 'package:intl/intl.dart';
import 'package:loginpage/controller/servo_layout.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gallery_saver/gallery_saver.dart';

class stream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: "TRIOT",
      home: Home(
        channel: IOWebSocketChannel.connect('ws://192.168.100.10:6969'),
      ),
    );
  }
}

class Home extends StatefulWidget {
  final WebSocketChannel channel;

  Home({Key? key, required this.channel}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double videoWidth = 640;
  final double videoHeight = 380;

  double newVideoSizeWidth = 640;
  double newVideoSizeHeight = 380;

  bool isLandscape = false;
  var _timeString;

  @override
  void initState() {
    super.initState();
    isLandscape = false;

    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        if (orientation == Orientation.portrait) {
          //screenWidth < screenHeight

          isLandscape = false;
          newVideoSizeWidth =
              screenWidth > videoWidth ? videoWidth : screenWidth;
          newVideoSizeHeight = videoHeight * newVideoSizeWidth / videoWidth;
        } else {
          isLandscape = true;
          newVideoSizeHeight =
              screenHeight > videoHeight ? videoHeight : screenHeight;
          newVideoSizeWidth = videoWidth * newVideoSizeHeight / videoHeight;
        }

        return Container(
            color: Colors.grey[300],
            // child: Padding(
            //     padding: EdgeInsets.only(top: screenHeight * 0.05),
            child: OverflowBox(
              minWidth: newVideoSizeWidth,
              maxWidth: double.infinity,
              child: StreamBuilder(
                stream: widget.channel.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: isLandscape ? 0 : 30,
                            ),
                            Stack(
                              children: <Widget>[
                                FittedBox(
                                  fit: BoxFit.cover,
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(
                                  //     color: Colors.white,
                                  //     width: 1,
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(13),
                                  // ),
                                  child: ClipRect(
                                    child: GestureZoomBox(
                                      maxScale: 5.0,
                                      doubleTapScale: 2.0,
                                      duration: Duration(milliseconds: 200),
                                      child: Image.memory(
                                        snapshot.data,
                                        gaplessPlayback: true,
                                        width: newVideoSizeWidth,
                                        height: newVideoSizeHeight,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                    child: Align(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'Live | $_timeString',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.topCenter,
                                ))
                              ],
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.grey[300],
                                width: MediaQuery.of(context).size.width,
                                child: Expanded(
                                  child: ServoLayout(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
            ));
      }),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd hh:mm:ss aaa').format(dateTime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    setState(() {
      _timeString = _formatDateTime(now);
    });
  }
}
