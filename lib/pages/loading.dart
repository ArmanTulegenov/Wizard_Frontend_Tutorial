import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/services/sqlite/sqlite_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/websocket/websocket_service.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setUp() async {
    Future(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    title: 'Home page',
                  )));
    });
  }

  Future<void> initDB() async {
    final SqliteService sqliteHelper = SqliteService();
  }

  Future<void> initWebsocket() async {
    final WebSocketService webSocketSingleton =
        WebSocketService();
  }

  @override
  void initState() {
    super.initState();
    setUp();
    initDB();
    initWebsocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SpinKitFoldingCube(color: Colors.white, size: 80.0)),
    );
  }
}
