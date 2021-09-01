import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BaseModel extends ChangeNotifier{

  int _stackIndex = 0;
  List _entityList = [];
  var entityBeingEdited;
  String? _chosenDate;

  int get stackIndex => _stackIndex;
  set stackIndex(int index){
    _stackIndex = index;
    notifyListeners();
  }

  String? get chosenDate => _chosenDate;
  set chosenDate(String? value) {
    _chosenDate = value;
    notifyListeners();
  }

  List get data => _entityList;
  loadData(String inEntityType,dynamic inDataBase) async{
    _entityList = await inDataBase.getAll();
    notifyListeners();
  }

  BaseModel();
}