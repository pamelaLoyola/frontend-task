import 'package:flutter/material.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:dropwdown/models/parent_model.dart';
import 'package:dropwdown/data/register_data.dart';
import 'package:dropwdown/utils/sizing_info.dart';

class InfoTile extends StatefulWidget {
  InfoTile({Key? key}) : super(key: key);

  @override
  _InfoTileState createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  late List<DragAndDropList> _lists;
  late List<DragAndDropItem> _items = [];
  double _expandedTileHeigh = 200;
  bool _isExpanded = false;

  @override
  void initState() {
    _lists = List.generate(1, (index) {
      return DragAndDropList(
        header: Text("Lista de familiares $index"),
        children: _items,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return ExpansionTile(
      title: Text("Info of parents"),
      trailing: Icon(_isExpanded
          ? Icons.keyboard_arrow_up_rounded
          : Icons.keyboard_arrow_down_rounded),
      textColor: Theme.of(context).primaryColor,
      iconColor: Theme.of(context).primaryColor,
      onExpansionChanged: (value) => setState(() {
        _isExpanded = value;
        _expandedTileHeigh = _height;
      }),
      children: [
        tileHeaderContainer(),
        tileDraggableBody(),
      ],
    );
  }

  Widget tileHeaderContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: isDesktop(context) ? desktopTileHeader() : mobileTileHeader(),
    );
  }

  Widget tileDraggableBody() {
    return Container(
      height: _expandedTileHeigh - 230,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: DragAndDropLists(
        children: _lists,
        onItemReorder: _onItemReorder,
        onListReorder: _onListReorder,
        // ),
      ),
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
              child: isDesktop(context) ? desktopTileBody() : mobileTileBody(),
            ),
          );
        },
      ),
    );
  }

  //Needs an index
  Widget desktopTileBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('name'),
        Text('name'),
        Text('name'),
        Text('name'),
        IconButton(
          onPressed: () {
            // setState(() {
            //   parents.removeAt(index);
            // });
          },
          icon: Icon(Icons.delete),
        )
      ],
    );
  }

  Widget mobileTileBody() {
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
                  // setState(() {
                  //   parents.removeAt(index);
                  // });
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
          onPressed: () => addItem(),
          icon: Icon(Icons.add),
        )
      ],
    );
  }

  Widget mobileTileHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Add a new parent'),
        IconButton(
          onPressed: () => addItem(),
          icon: Icon(Icons.add),
        )
      ],
    );
  }

  void addItem() {
    setState(() {
      ParentModel newParent = ParentModel(name: 'Pamela', lastname: 'Loyola');

      _items.add(buildParentItem(newParent));
    });
  }

  DragAndDropItem buildParentItem(ParentModel parent) => DragAndDropItem(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: isDesktop(context) ? desktopTileBody() : mobileTileBody(),
          ),
        ),
      );

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _lists[oldListIndex].children.removeAt(oldItemIndex);
      _lists[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _lists.removeAt(oldListIndex);
      _lists.insert(newListIndex, movedList);
    });
  }
}
