import 'package:dropwdown/data/register_data.dart';
import 'package:dropwdown/utils/sizing_info.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatefulWidget {
  InfoTile({Key? key}) : super(key: key);

  @override
  _InfoTileState createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Info of parents"),
      trailing: Icon(_isExpanded
          ? Icons.keyboard_arrow_up_rounded
          : Icons.keyboard_arrow_down_rounded),
      textColor: Theme.of(context).primaryColor,
      iconColor: Theme.of(context).primaryColor,
      onExpansionChanged: (value) => setState(() => _isExpanded = value),
      children: [
        tileHeaderContainer(),
        tileBodyContainer(),
      ],
    );
  }

  Widget tileHeaderContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: isDesktop(context) ? desktopTileHeader() : mobileTileHeader(),
    );
  }

  Widget tileBodyContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 300,
      child: ListView.builder(
        itemCount: parents.length,
        itemBuilder: (contex, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: isDesktop(context)
                  ? desktopTileBody(index)
                  : mobileTileBody(index),
            ),
          );
        },
      ),
    );
  }

  Widget desktopTileBody(index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('name'),
        Text('name'),
        Text('name'),
        Text('name'),
        IconButton(
          onPressed: () {
            setState(() {
              parents.removeAt(index);
            });
          },
          icon: Icon(Icons.delete),
        )
      ],
    );
  }

  Widget mobileTileBody(index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Name ',
                labelStyle: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding: EdgeInsets.only(left: 5),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal,
                  ),
                )),
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'ID Number',
                labelStyle: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding: EdgeInsets.only(left: 5),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal,
                  ),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    parents.removeAt(index);
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.teal.withOpacity(0.4),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget desktopTileHeader() {
    return Row(
      // mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Name'),
        Text('Name'),
        Text('Name'),
        Text('Name'),
        IconButton(
            onPressed: () {
              setState(() => parents.add('widget'));
            },
            icon: Icon(Icons.add))
      ],
    );
  }

  Widget mobileTileHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Add a new parent'),
        IconButton(
            onPressed: () {
              setState(() => parents.add('widget'));
            },
            icon: Icon(Icons.add))
      ],
    );
  }
}
