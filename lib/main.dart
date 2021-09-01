import 'package:flutter/material.dart';
import 'package:pim_book/features/appointments/data/appointments_db_worker.dart';
import 'package:pim_book/features/appointments/domain/appointments_model.dart';
import 'package:pim_book/features/tasks/data/tasks_db_worker.dart';
import 'package:pim_book/features/tasks/domain/tasks_model.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'core/utils.dart' as utils;
import 'package:path_provider/path_provider.dart';
import 'features/appointments/ui/appointments.dart';
import 'features/contacts/ui/contacts.dart';
import 'features/notes/data/notes_db_worker.dart';
import 'features/notes/domain/notes_model.dart';
import 'features/notes/ui/notes.dart';
import 'features/tasks/ui/tasks.dart';

void main()=> runApp(PIMBook());

class PIMBook extends StatefulWidget {
  PIMBook({Key? key}) : super(key: key);


  final List<Widget> tabs = [
    //Notes(),
    Tasks(),
   // Appointments(),
    //Contacts(),
  ];

  @override
  _PIMBookState createState() => _PIMBookState();
}

class _PIMBookState extends State<PIMBook> {


  Future<Directory?> setUpAppDirectory() async{
    /// retrieve the the app's documents directory
    /// and pass it to utils.docsDir Directory
    Directory? docsDir = await getApplicationDocumentsDirectory();
    utils.docsDir = docsDir;
    return docsDir;
    //notesModel.loadData("notes",NotesDBWorker.instance);
    //appointmentsModel.loadData("appointments", AppointmentsDBWorker.instance);
    context.read<TasksModel>().loadData("tasks", TasksDBWorker.instance);
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => TasksModel(),),
      ],
      child:  MaterialApp(
        title: "PIMBook",
        theme : ThemeData.dark(),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: Text("PIMBook"),
                leading: PopupMenuButton(
                  icon: Icon(Icons.menu_rounded),
                  onSelected: (int value){
                    print("change theme pos : $value");
                  },
                  itemBuilder: (context)=>[
                    PopupMenuItem(value: 0,child: ListTile(title :Text("theme"),trailing: Icon(Icons.style)))
                  ],
                ),
                // bottom: TabBar(
                //   unselectedLabelStyle: TextStyle(fontSize: 0.0),
                //   tabs: [
                //     Tab(icon: Icon(Icons.sticky_note_2,size: 20),text: "Note",),
                //     Tab(icon: Icon(Icons.assignment_turned_in,size: 20),text: "Task",),
                //     Tab(icon: Icon(Icons.date_range,size: 20,),text: "Appointment",),
                //     //Tab(icon: Icon(Icons.contacts,size: 20),text: "Contact",),
                //   ],
                // ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.sticky_note_2,size: 20),label: "Note",),
                  BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in,size: 20,),label: "Task",),
                  BottomNavigationBarItem(icon: Icon(Icons.date_range,size: 20),label: "Appointment",),
                  // BottomNavigationBarItem(icon: Icon(Icons.contacts,size: 20),label: "Contact",),
                ],
                currentIndex: _currentIndex,
                onTap: (int index){
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              body: Tasks()
            //todo : tabs
            // IndexedStack(
            //     index: _currentIndex,
            //     children: widget.tabs,
            // ),
          ),
        ),
      ),
    );
  }
}



