import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/events/data/events_db_worker.dart';
import 'package:pim_book/features/events/domain/pim_event.dart';

import '../../../core/utils.dart';
import '../data/events_db_worker.dart';

class EventsEntryController extends GetxController{

  PIMEvent event;

  RxString chosenDate = "".obs;
  RxString apptTime= "".obs;

  late TextEditingController titleTextEditingController;
  late TextEditingController contentTextEditingController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  EventsEntryController(this.event){

    /// add listener to textField when ever the data changes
    /// we pass it to entity being edited
    titleTextEditingController = TextEditingController();
    contentTextEditingController= TextEditingController();

    titleTextEditingController.addListener(() {
      event.title = titleTextEditingController.text;
    });
    contentTextEditingController.addListener(() {
      event.description = contentTextEditingController.text;
    });

    /// case we entity being edited exist and we just wont to update it
    /// if entity being edited is a new note the title and content length is 0
    titleTextEditingController.text = event.title;
    contentTextEditingController.text = event.description;
  }


  onSavePressed()async{
    if (!formKey.currentState!.validate()) return;
    if (event.id == null)  {
      await EventsDBWorker().create(event);
    } else{
      await EventsDBWorker().update(event);
    }

    Get.showSnackbar(
        GetSnackBar(
            duration: Duration(seconds: 2),
            message : "appointment saved"
        )
    );
    Get.back();
    //TODO update the list after saving
  }



  //todo set it in entry ctrl
  onEditDate(BuildContext context) async {
    String chosenDate = await Utils.selectDate(context, event.startDate);
    event.startDate = chosenDate;
  }

  onEditTime(BuildContext context) async {
    String chosenTime = await Utils.selectTime(context,apptTime.value);
    apptTime.value = chosenTime;
  }


}