import 'package:flutter/material.dart';

class ParentModel with ChangeNotifier {
  String relationType;
  String id;
  String pedegree;
  String senasa;

  ParentModel({
    this.relationType = "",
    this.id = "",
    this.pedegree = "",
    this.senasa = "",
  });
}
