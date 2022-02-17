import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pim_book/features/appointments/controller/appointments_controller.dart';
import 'package:pim_book/features/appointments/controller/appointments_list_controller.dart';
import 'package:pim_book/features/appointments/data/appointments_db_worker.dart';
import 'package:pim_book/features/appointments/domain/appointment.dart';
import 'package:pim_book/core/utils.dart' as utils;


class AppointmentsList extends StatelessWidget {

  AppointmentsList(this.appointmentsCtrl);

  final AppointmentsController appointmentsCtrl;

  Future _deleteAppointments(BuildContext context, Appointment appointment) {
    return showDialog(
        context: context,
        builder: (BuildContext inContext) {
          return Obx(()=>AlertDialog(
            title: Text("Delete"),
            content: Text("Are you sure you wont delete ${appointment.title}"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(inContext);
                  },
                  child: Text("cancel")),
              TextButton(
                  onPressed: () async {
                    await AppointmentsDBWorker.instance.delete(appointment.id!);
                    Navigator.pop(inContext);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text(
                          "Appointment deleted",
                          style: TextStyle(color: Colors.redAccent),
                        )));
                    appointmentsCtrl.loadData(
                        "appointments", AppointmentsDBWorker.instance);
                  },
                  child: Text("delete")),
            ],
          ));
          });
  }

  void _editAppointments(BuildContext inContext, Appointment appointment) async {
    if (appointmentsCtrl.entityBeingEdited.value.apptDate == null) {
      appointmentsCtrl.chosenDate = null;
    } else {
      DateTime date = utils
          .dateTimeFromString(appointmentsCtrl.entityBeingEdited.value.apptDate!);
      appointmentsCtrl.chosenDate =
          DateFormat.yMMMMd('en_US').format(date.toLocal());
    }
    if (appointmentsCtrl.entityBeingEdited.value.apptTime == null) {
      appointmentsCtrl.apptTime = null;
    } else {
      TimeOfDay time = utils
          .timeOfDayFromString(appointmentsCtrl.entityBeingEdited.value.apptTime!);
      appointmentsCtrl.apptTime = time.format(inContext);
    }
    appointmentsCtrl.stackIndex = 1;

  }

  @override
  Widget build(BuildContext context) {


    EventList<Event> _markedDateMap = EventList(events: {});
    for (int i = 0; i < appointmentsCtrl.data.length; i++) {
      Appointment appointment = appointmentsCtrl.data[i];
      DateTime apptDate = utils.dateTimeFromString(appointment.apptDate!);
      _markedDateMap.add(
          apptDate,
          Event(
              date: apptDate,
              icon: Icon(Icons.circle,size: 5,),
              dot: Icon(Icons.circle,size: 8,color: Theme.of(context).errorColor,),
          )
      );
    }


    return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              appointmentsCtrl.onNewEntryPressed();
            },
            child: Icon(Icons.add),
          ),
          body: Column(
            children: [
              Expanded(
                child:CalendarCarousel<Event>(
                  todayButtonColor: Theme.of(context).backgroundColor,
                  todayTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color :Theme.of(context).primaryColorDark),
                  daysTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400),
                  headerTextStyle: Theme.of(context).textTheme.headline5,
                  weekdayTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color :Theme.of(context).primaryColor),
                  weekendTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w900),
                  //daysHaveCircularBorder: false,
                  markedDatesMap: _markedDateMap,
                  onDayPressed: (DateTime date, List<Event> events) {
                    _showAppointments(context, date, events);
                  },
                ),
              )
            ],
          ),
        );
  }

  void _showAppointments(
    BuildContext context, DateTime date, List<Event> events) async {

    showBottomSheet(
        context: context,
        builder: (context) {
          return Obx(()=>Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              child: Column(
                children: [
                  Text(
                    DateFormat.yMMMMd("en_US").format(date.toLocal()),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24),
                  ),
                  Divider(),
                  Expanded(child: ListView.builder(
                      itemCount: appointmentsCtrl.data.length,// list ctrl
                      itemBuilder: (inInContext, index){
                        Appointment appointment =
                        appointmentsCtrl.data[index]; // list ctrl
                        if(appointment.apptDate != "${date.year},${date.month},${date.day}"){
                          return SizedBox.shrink();
                        }
                        String? apptTime;
                        if (appointment.apptTime != null) {
                          TimeOfDay time = utils.timeOfDayFromString(appointment.apptTime!);
                          apptTime = " (${time.format(inInContext)})";
                        }
                        return Slidable(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8.0),
                            color: Colors.grey.withOpacity(0.2),
                            child: ListTile(
                              title:
                              Text("${appointment.title}$apptTime"),
                              subtitle: Text(appointment.description!),
                              onTap: () async {
                                _editAppointments(context, appointment);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          actionPane: SlidableStrechActionPane(),
                          secondaryActions: [
                            IconSlideAction(
                              icon: Icons.delete,
                              foregroundColor: Colors.redAccent,
                              onTap: () async {
                                _deleteAppointments(
                                    inInContext, appointment);
                              },
                            )
                          ],
                        );
                      }
                  ),),
                ],
              ),
            ),
          )
          );
        });
  }
}
