import 'package:flutter/material.dart';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

import 'package:dropwdown/models/parent_model.dart';
import 'package:dropwdown/utils/sizing_info.dart';

class InfoTile extends StatefulWidget {
  InfoTile({Key? key}) : super(key: key);

  @override
  _InfoTileState createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  ParentModel parent = ParentModel();

  //TextInput controllers
  final _idController = TextEditingController();
  final _pedegreeController = TextEditingController();
  final _senasaController = TextEditingController();

  //MediaQuery size values
  late double _width;
  late double _height;

  //Draggables items and list
  late List<DragAndDropItem> draggableItemsList = [];
  late List<DragAndDropList> draggableList;

  //Dropdown options
  late List _filteredRelations;
  List _relations = [
    {'name': 'Mother', 'isSelected': false},
    {'name': 'Father', 'isSelected': false},
    {'name': 'M. Grandma', 'isSelected': false},
    {'name': 'M. Grandpa', 'isSelected': false},
    {'name': 'P. Grandma', 'isSelected': false},
    {'name': 'P. Grandpa', 'isSelected': false}
  ];

  String _relationSelected = "Select Relative";
  double _expandedTileHeigh = 200;
  bool _isExpanded = false;

  @override
  void initState() {
    //Initialize draggable list
    draggableList = [
      DragAndDropList(
        header: draggableListHeader(),
        children: draggableItemsList,
      )
    ];

    // Initialize filtered relations list
    _filteredRelations = _relations;

    //Text Controllers listener
    _idController.addListener(() => parent.id = _idController.text);
    _pedegreeController
        .addListener(() => parent.pedegree = _pedegreeController.text);
    _senasaController.addListener(() => parent.senasa = _senasaController.text);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return infoParentsTile();
  }

  Widget infoParentsTile() {
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
      children: [tileHeader(), draggableParentsList()],
    );
  }

  Widget tileHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.black.withAlpha(10),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          //If it's desktop there is no header, instead return an empty container
          isDesktop(context) ? Container() : mobileTileHeader(),
          //Below return the form container
          formContainer(),
        ],
      ),
    );
  }

  Widget draggableParentsList() {
    return Container(
      height: _expandedTileHeigh - 230,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: DragAndDropLists(
        children: draggableList,
        onItemReorder: _onItemReorder,
        onListReorder: _onListReorder,
        // ),
      ),
    );
  }

  Widget mobileTileHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add a new parent',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          addParentButton()
        ],
      ),
    );
  }

  Widget draggableListHeader() {
    final TextStyle _inputStyle =
        TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.teal.shade400, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Relative', style: _inputStyle),
          Text('ID Number', style: _inputStyle),
          Text('Pedegree ID', style: _inputStyle),
          Text('Senasa ID', style: _inputStyle),
          // Container(width: 20)
        ],
      ),
    );
  }

  Widget formContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: isDesktop(context) ? desktopForm() : mobileForm(),
    );
  }

  Widget desktopForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        relationsDropdown(),
        fieldInput('ID', _idController),
        fieldInput('Pedegree ID', _pedegreeController),
        fieldInput('Senasa ID', _senasaController),
        addParentButton()
      ],
    );
  }

  Widget mobileForm() {
    return Column(
      children: [
        relationsDropdown(),
        fieldInput('ID', _idController),
        fieldInput('Pedegree ID', _pedegreeController),
        fieldInput('Senasa ID', _senasaController),
      ],
    );
  }

  Widget relationsDropdown() {
    return Container(
      width: isDesktop(context) ? _width / 4.5 : _width,
      height: 40,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white.withAlpha(100),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButton(
        isExpanded: true,
        underline: SizedBox(),
        hint: Text(_relationSelected),
        onChanged: (value) {
          setState(() {
            _relationSelected = value.toString();
            parent.relationType = _relationSelected;
          });
        },
        items: _getRelationsItems(),
      ),
    );
  }

  Widget fieldInput(String fieldName, TextEditingController controller) {
    return Container(
      width: isDesktop(context) ? _width / 4.5 : _width,
      height: 40,
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white.withAlpha(100),
          borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
            hintText: fieldName,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none),
      ),
    );
  }

  Widget addParentButton() {
    return IconButton(
      onPressed: () => addItem(),
      icon: Icon(Icons.add),
    );
  }

  DragAndDropItem draggableParentItem(ParentModel parent) {
    return DragAndDropItem(
      child: parentItemCard(parent),
    );
  }

  Widget parentItemCard(ParentModel parent) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                parent.relationType,
                textAlign: TextAlign.end,
              ),
            ),
            Text(parent.id),
            Text(parent.pedegree),
            Text(parent.senasa),
            // IconButton(
            //   onPressed: () {
            //     //TODO: delete a parent
            //   },
            //   padding: EdgeInsets.zero,
            //   iconSize: 20,
            //   icon: Icon(
            //     Icons.delete,
            //     color: Colors.teal.withOpacity(0.4),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void addItem() {
    if (parent.relationType.isNotEmpty &&
        parent.id.isNotEmpty &&
        parent.pedegree.isNotEmpty &&
        parent.senasa.isNotEmpty) {
      setState(() {
        draggableItemsList.add(draggableParentItem(parent));

        _relations.forEach((element) {
          if (element['name'] == _relationSelected)
            element['isSelected'] = true;
        });

        _filteredRelations = _relations
            .where((element) => element['isSelected'] == false)
            .toList();
      });

      _cleanData();
    }
  }

  _getRelationsItems() {
    return _filteredRelations
        .map((opt) =>
            DropdownMenuItem(value: opt['name'], child: Text(opt['name'])))
        .toList();
  }

  _cleanData() {
    parent.relationType = "";
    _relationSelected = "Select Relation";
    _idController.text = "";
    _pedegreeController.text = "";
    _senasaController.text = "";
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem =
          draggableList[oldListIndex].children.removeAt(oldItemIndex);
      draggableList[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = draggableList.removeAt(oldListIndex);
      draggableList.insert(newListIndex, movedList);
    });
  }
}
