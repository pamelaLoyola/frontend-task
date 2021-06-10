import 'package:flutter/material.dart';
import 'package:dropwdown/pages/home_page.dart';
import 'package:dropwdown/testPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      initialRoute: 'home',
      routes: {'home': (BuildContext context) => HomePage()},
      // builder: (context, child) {
      //   return Theme(
      //     data: ThemeData(primaryColor: Colors.pink),
      //     child: HomePage(),
      //   );
      // },
    );
  }
}
