import 'package:pim_book/features/events/data/events_db_worker.dart';

import 'pim_event.dart';

class EventsModel{

  String? _apptTime;
  int _stackIndex = 0;
  List _entityList = [];
  var appointmentsBeingEdited;
  String? _chosenDate;


  int get stackIndex => _stackIndex;
  set stackIndex(int index){
    _stackIndex = index;
    //notifyListeners();
  }

  String? get chosenDate => _chosenDate;
  set chosenDate(String? value) {
    _chosenDate = value;
    //notifyListeners();
  }

  List get data => _entityList;
  loadData() async{
    _entityList = await  EventsDBWorker().getAll();
    //notifyListeners();
  }


  EventsModel(){
    appointmentsBeingEdited = PIMEvent();
    loadData();
  }

  set apptTime(String? value) {
    _apptTime = value;
    //notifyListeners();
  }
  String? get apptTime => _apptTime;
}