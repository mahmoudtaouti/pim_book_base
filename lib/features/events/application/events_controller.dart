
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils.dart';
import '../../events/domain/pim_event.dart';
import '../data/events_db_worker.dart';
import '../ui/events_entry.dart';


class EventsController extends GetxController {


  List eventsList = [].obs;
  PIMEvent eventBeingEdited = PIMEvent();
  RxString chosenDate = "".obs;//TODO should have a valid date format y,m,d
  RxString apptTime= "".obs;// TODO should have a valid date format h,m



  EventsController(){
    updateListData();//null pointer db worker
  }


  updateListData() async{
    EventsDBWorker db = EventsDBWorker();
    eventsList = await db.getAll();
  }




  //add new events button pressed
  onNewEntryPressed(){
    eventBeingEdited = PIMEvent();
    eventBeingEdited.startDate = Utils.getNowDateStringFormat();
    chosenDate.value = DateFormat.yMMMMd("en_US").format(DateTime.now().toLocal());
    Get.to(EventsEntry(eventBeingEdited));
  }

  onDeleteEvent(PIMEvent appointment) async {
    await EventsDBWorker().delete(appointment.id!);
    Get.back();
    Get.showSnackbar(GetSnackBar(
        duration: Duration(seconds: 2),
        message : "Event deleted",
        ));
   updateListData();
  }

  onEditAppointment(){
    Get.to(EventsEntry(eventBeingEdited));
  }

  onDaySelected(){

  }


}