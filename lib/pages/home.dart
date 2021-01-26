import 'package:flutter/material.dart';
import 'package:flutter_app/services/sqlite/sqlite_service.dart';
import 'package:flutter_app/services/websocket/listener/user_link_listener.dart';
import '../services/websocket/websocket_service.dart';
import '../services/crypto/crypto_service.dart';
import '../models/user_details.dart';

import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SqliteService sqlService = new SqliteService();
  final WebSocketService webSocketServiceSingleton = new WebSocketService();

  int _counter = 0;
  Map data = {};

  /*
    void _launchURL() async {
    if (await canLaunch(url)) {
      Navigator.pushReplacementNamed(context, '/home',
          arguments: {'identity': identity});
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
   */

  Future<void> processLoginOrRegister(String pinCode) async {
    UserDetails userDetails = await sqlService.getUserDetailsByUserName(pinCode);
    if (null == userDetails ||  null == userDetails.password) {
      // send connect
      // create identity
      await webSocketServiceSingleton.doRegistrationOrRestore(pinCode);
    } else {
      // send registration link
      await webSocketServiceSingleton.doLogin(userDetails);
      //
      // Navigator.pushReplacementNamed(context, '/registration');
    }
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    webSocketServiceSingleton.addListener(UserLinkListener());
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    final pinController = TextEditingController();

    data = ModalRoute.of(context).settings.arguments;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final passwordField = TextField(
      obscureText: true,
      style: style,
      controller: pinController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Pin code",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final registerOrLoginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          String pinCode = pinController.text.trim();
          processLoginOrRegister(pinCode);
        },
        child: Text("Login Or Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
        body: Center(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 15.0),
              passwordField,
              SizedBox(
                height: 15.0,
              ),
              registerOrLoginButton,
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
