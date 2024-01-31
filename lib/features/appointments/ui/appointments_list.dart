import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pim_book/features/appointments/data/appointments_db_worker.dart';
import 'package:pim_book/features/appointments/domain/appointment.dart';
import 'package:pim_book/features/appointments/domain/appointments_model.dart';
import 'package:pim_book/core/utils.dart' as utils;
import 'package:provider/provider.dart';

class AppointmentsList extends StatelessWidget {

  _deleteAppointments(BuildContext context, Appointment appointment) {
    return showDialog(
        context: context,
        builder: (BuildContext inContext) {
          return AlertDialog(
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
                    Provider.of<AppointmentsModel>(context,listen: false).loadData(
                        "appointments", AppointmentsDBWorker.instance);
                  },
                  child: Text("delete")),
            ],
          );
        });
  }

  _editAppointments(
    BuildContext inContext, Appointment appointment) async {
    AppointmentsModel appointmentsModel=  Provider.of<AppointmentsModel>(inContext,listen: false);
    if (appointmentsModel.entityBeingEdited.apptDate == null) {
      appointmentsModel.chosenDate = null;
    } else {
      DateTime date = utils
          .dateTimeFromString(appointmentsModel.entityBeingEdited.apptDate);
      appointmentsModel.chosenDate =
          DateFormat.yMMMMd('en_US').format(date.toLocal());
    }
    if (appointmentsModel.entityBeingEdited.apptTime == null) {
      appointmentsModel.apptTime = null;
    } else {
      TimeOfDay time = utils
          .timeOfDayFromString(appointmentsModel.entityBeingEdited.apptTime);
      appointmentsModel.apptTime = time.format(inContext);
    }
    appointmentsModel.stackIndex = 1;
    Navigator.pop(inContext);
  }

  @override
  Widget build(BuildContext context) {
    AppointmentsModel appointmentsModel  = Provider.of<AppointmentsModel>(context);

    EventList<Event> _markedDateMap = EventList(events: {});
    for (int i = 0; i < appointmentsModel.data.length; i++) {
      Appointment appointment = appointmentsModel.data[i];
      DateTime apptDate = utils.dateTimeFromString(appointment.apptDate!);
      _markedDateMap.add(
          apptDate,
          Event(
              date: apptDate,
              icon: Icon(Icons.circle,size: 5,),
              dot: Icon(Icons.circle,size: 8,color: Theme.of(context).buttonColor,),
          )
      );
    }


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appointmentsModel.entityBeingEdited = Appointment();
          appointmentsModel.stackIndex = 1;
          DateTime nowTime = DateTime.now();
          (appointmentsModel.entityBeingEdited as Appointment)
              .apptDate =
          "${nowTime.year},${nowTime.month},${nowTime.day}";
          appointmentsModel.chosenDate =
              DateFormat.yMMMMd("en_US").format(nowTime.toLocal());
          appointmentsModel.apptTime = null;
          appointmentsModel.stackIndex = 1;
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child:CalendarCarousel<Event>(
              todayButtonColor: Theme.of(context).accentColor,
              todayTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color :Theme.of(context).primaryColorDark),
              daysTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400),
              headerTextStyle: Theme.of(context).textTheme.headline5,
              weekdayTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color :Theme.of(context).accentColor),
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
    );;
  }

  void _showAppointments(
    BuildContext context, DateTime date, List<Event> events) async {
    AppointmentsModel appointmentsModel  = Provider.of<AppointmentsModel>(context,listen: false);

    showBottomSheet(
        context: context,
        builder: (context) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                child: Column(
                  children: [
                    Text(
                      DateFormat.yMMMMd("en_US").format(date.toLocal()),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 24),
                    ),
                    Divider(),
                    Expanded(child: ListView.builder(
                        itemCount: appointmentsModel.data.length,
                        itemBuilder: (inInContext, index){
                          Appointment appointment =
                          appointmentsModel.data[index];
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
                                title: Text("${appointment.title}$apptTime"),
                                subtitle: Text(appointment.description!),
                              ),
                            ),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(onDismissed: () {}),
                              children: [
                                SlidableAction(
                                  onPressed: _editAppointments(context, appointment),
                                  backgroundColor: Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.share,
                                  label: 'Edit',
                                ),
                              ],
                            ),
                            endActionPane:  ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: _deleteAppointments(inInContext, appointment),
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ), // Add this line
                          );
                        }
                    ),),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
