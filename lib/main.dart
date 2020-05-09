import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xpense/screens/HomePage.dart';

void main() {
 // WidgetsFlutterBinding.ensureInitialized();                        // this code above the runApp code prevents the screen to rotate in landscape mode.
  //SystemChrome.setPreferredOrientations(
   //   [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
