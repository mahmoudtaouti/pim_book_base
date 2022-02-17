import 'package:get/get.dart';
import 'package:pim_book/features/appointments/controller/appointments_controller.dart';
import 'package:pim_book/features/appointments/data/appointments_db_worker.dart';

class AppointmentsListController extends GetxController{
  List _entityList = [];

  AppointmentsListController(){
    loadData("appointments", AppointmentsDBWorker.instance);//null pointer db worker
  }
  List get data => _entityList;
  loadData(String inEntityType,dynamic inDataBase) async{
    _entityList = await inDataBase.getAll();
    update();
  }

}