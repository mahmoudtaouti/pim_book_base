import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pim_book/features/appointments/data/appointments_db_worker.dart';
import 'package:pim_book/features/appointments/domain/appointment.dart';


class AppointmentsController extends GetxController {

  RxInt _stackIndex = 0.obs;
  List _entityList = [].obs;
  var entityBeingEdited = Appointment().obs;
  RxString _chosenDate = "".obs;
  RxString _apptTime= "".obs;

  String? get chosenDate => _chosenDate.value;

  String? get apptTime => _apptTime.value;

  AppointmentsController(){
    loadData("appointments", AppointmentsDBWorker.instance);//null pointer db worker
    entityBeingEdited.value = Appointment();
  }

  List get data => _entityList;
  loadData(String inEntityType,dynamic inDataBase) async{
    _entityList = await inDataBase.getAll();
    update();
  }


  int get stackIndex => _stackIndex.value;
  set stackIndex(int index){
    _stackIndex.value = index;
    update();
  }



  set apptTime(String? value) {
    _apptTime.value = value!;
    update();
  }



  set chosenDate(String? value) {
    _chosenDate.value = value!;
    update();
  }


  //add new appointments button pressed
  onNewEntryPressed(){
    stackIndex = 1;//appointments ctrl
    entityBeingEdited.value = Appointment();
    DateTime nowTime = DateTime.now();
    (entityBeingEdited as Appointment)
        .apptDate =
    "${nowTime.year},${nowTime.month},${nowTime.day}";
    chosenDate =
        DateFormat.yMMMMd("en_US").format(nowTime.toLocal());
    apptTime = null;  //todo move to entry
  }



}