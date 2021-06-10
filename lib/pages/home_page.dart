import 'package:dropwdown/data/register_data.dart';
import 'package:dropwdown/widgets/components/info_tile/info_tile.dart';
import 'package:flutter/material.dart';
import 'package:dropwdown/widgets/components/image_container.dart';

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
            children: [ImageContainer(), InfoTile()],
          ),
        ));
  }
}
