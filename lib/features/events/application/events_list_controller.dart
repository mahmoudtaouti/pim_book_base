import 'package:get/get.dart';
import 'package:pim_book/features/events/data/events_db_worker.dart';

class EventsListController extends GetxController{
  List _entityList = [];

  EventsListController(){
    loadData("events", EventsDBWorker());//null pointer db worker
  }
  List get data => _entityList;
  loadData(String inEntityType,dynamic inDataBase) async{
    _entityList = await inDataBase.getAll();
    update();
  }

}