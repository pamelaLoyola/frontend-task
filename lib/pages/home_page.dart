import 'package:flutter/material.dart';

import 'package:dropwdown/widgets/image_container.dart';
import 'package:dropwdown/widgets/info_parents_tile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Relations"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ImageContainer(),
              InfoTile(),
            ],
          ),
        ));
  }
}
