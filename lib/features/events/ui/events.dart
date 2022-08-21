import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pim_book/features/events/application/events_controller.dart';
import '../domain/pim_event.dart';

class Events extends StatelessWidget {
  Events({Key? key}) : super(key: key);

  final EventsController eventsCtrl =
      Get.put(EventsController(), tag: "eventsCtrl");

  Future _deleteAppointments(BuildContext context, PIMEvent pimEvent) {
    return showDialog(
        context: context,
        builder: (BuildContext inContext) {
          return Obx(() => AlertDialog(
                title: Text("Delete"),
                content:
                    Text("Are you sure you wont delete ${pimEvent.title}"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("cancel")),
                  TextButton(
                      onPressed: () {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     duration: Duration(seconds: 2),
                        //     content: Text(
                        //       "Appointment deleted",
                        //       style: TextStyle(color: Colors.redAccent),
                        //     )));
                        eventsCtrl.onDeleteEvent(pimEvent);
                      },
                      child: Text("delete")),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    EventList<Event> _markedDateMap = EventList(events: {});
    for (int i = 0; i < eventsCtrl.eventsList.length; i++) {
      PIMEvent pimEvent = eventsCtrl.eventsList[i];
      DateTime apptDate = DateTime(pimEvent.startDate!);
      _markedDateMap.add(
          apptDate,
          Event(
            date: apptDate,
            title: pimEvent.title,
            icon: Icon(
              Icons.circle,
              size: 5,
            ),
            dot: Icon(
              Icons.circle,
              size: 8,
              color: Theme.of(context).errorColor,
            ),
          ));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "addNewAppointment",
        onPressed: () {
          eventsCtrl.onNewEntryPressed();
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: CalendarCarousel<Event>(
              todayButtonColor: Theme.of(context).backgroundColor,
              todayTextStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).primaryColorDark),
              daysTextStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w400),
              headerTextStyle: Theme.of(context).textTheme.headline5,
              weekdayTextStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).primaryColor),
              weekendTextStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w900),
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
          return Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              child: Column(
                children: [
                  Text(
                    DateFormat.yMMMMd("en_US").format(date.toLocal()),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 24),
                  ),
                  Divider(
                    thickness: 2,
                    color: Get.theme.primaryColor.withOpacity(0.7),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: eventsCtrl.eventsList.length,
                        // list ctrl problem that this length not = to total list length on ctrl
                        itemBuilder: (inInContext, index) {
                          PIMEvent pimEvent = eventsCtrl
                              .eventsList[index]; // list ctrl
                          if (pimEvent.startDate !=
                              "${date.year},${date.month},${date.day}") {
                            return SizedBox.shrink();
                          }
                          String? apptTime;
                          if (pimEvent.endDate != null) {
                            TimeOfDay time = TimeOfDay.fromDateTime(
                                DateTime(pimEvent.endDate!));
                            apptTime = " (${time.format(inInContext)})";
                          }
                          return Slidable(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8.0),
                              color: Colors.grey.withOpacity(0.2),
                              child: ListTile(
                                title: Text("${pimEvent.title}$apptTime"),
                                subtitle: Text(pimEvent.description),
                                onTap: () async {
                                  eventsCtrl.onEditAppointment();
                                  // Navigator.pop(context);
                                },
                              ),
                            ),
                            actionPane: SlidableStrechActionPane(),
                            secondaryActions: [
                              IconSlideAction(
                                icon: Icons.delete,
                                foregroundColor: Colors.redAccent,
                                onTap: () async {
                                  _deleteAppointments(inInContext, pimEvent);
                                },
                              )
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
