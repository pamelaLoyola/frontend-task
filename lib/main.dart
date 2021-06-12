import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:dropwdown/models/parent_model.dart';
import 'package:dropwdown/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ParentModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ThemeData(
          primaryColor: Colors.teal,
        ),
        initialRoute: 'home',
        routes: {'home': (BuildContext context) => HomePage()},
      ),
    );
  }
}
