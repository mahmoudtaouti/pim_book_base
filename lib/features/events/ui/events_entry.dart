import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/events/application/events_entry_controller.dart';
import 'package:pim_book/features/events/domain/pim_event.dart';



class EventsEntry extends StatelessWidget {

  EventsEntry(this.appointment){
    entryCtrl = Get.put(EventsEntryController(appointment),tag: "AppointmentsEntryController");
  }

  final PIMEvent appointment;
  late final EventsEntryController entryCtrl;


  @override
  Widget build(BuildContext context) {

        return Scaffold(
          backgroundColor: Colors.white12,
          body: Container(
            margin: EdgeInsets.symmetric(vertical: Get.height/10,horizontal: Get.width/20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Scaffold(
                bottomNavigationBar:Padding(
                  padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: (){
                        FocusScope.of(context).requestFocus(FocusNode());
                      }, child: Text("cancel",style: TextStyle(fontSize: 18),)),
                      TextButton(onPressed: (){
                        entryCtrl.onSavePressed();
                      }, child: Text("save",style: TextStyle(color: Colors.greenAccent,fontSize: 18),)),
                    ],
                  ),
                ),

                body: Form(
                  key : entryCtrl.formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                          controller: entryCtrl.titleTextEditingController,
                          decoration: InputDecoration(
                              hintText: "Meeting : alphaTeam",
                              prefixIcon: Icon(Icons.short_text_rounded)
                          ),
                          validator: (String? inValue){
                            if (inValue!.length == 0) {
                              return "please enter a title";
                            }
                            return null;
                          }
                      ),

                      TextFormField(
                          controller: entryCtrl.contentTextEditingController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          decoration: InputDecoration(
                              hintText: "Yes! Finally",
                              prefixIcon: Icon(Icons.text_snippet_outlined)
                          ),
                      ),


                      ListTile(
                        leading: Icon(Icons.date_range),
                        title: Text("Date"),
                        subtitle: Text(entryCtrl.chosenDate.value),

                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await entryCtrl.onEditDate(context);
                          },
                        ),
                      ),


                      ListTile(
                        leading: Icon(Icons.access_time),
                        title: Text("Time"),
                        subtitle: Text(entryCtrl.apptTime.value),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            entryCtrl.onEditTime(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
