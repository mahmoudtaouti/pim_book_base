import 'package:flutter/material.dart';
import 'package:pim_book/core/theme/pim_theme.dart';
import 'package:pim_book/features/appointments/domain/appointments_model.dart';
import 'package:pim_book/features/tasks/domain/tasks_model.dart';
import 'package:provider/provider.dart';
import 'core/theme/config.dart';
import 'core/utils.dart' as utils;
import 'features/appointments/ui/appointments.dart';
import 'features/notes/domain/notes_model.dart';
import 'features/notes/ui/notes.dart';
import 'features/tasks/ui/tasks.dart';

void main(){
  runApp(PIMBook());
}

class PIMBook extends StatefulWidget {
  PIMBook({Key? key}) : super(key: key);

  final List<Widget> tabs = [
    Tasks(),
    Notes(),
    Appointments(),
    //Contacts(),
  ];

  @override
  _PIMBookState createState() => _PIMBookState();
}

class _PIMBookState extends State<PIMBook> {


  int _currentIndex = 0;

  @override
  void initState() {
    utils.Utils.docsDir;
    currentThemeMode.addListener(() {

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => TasksModel(),),
        ChangeNotifierProvider(create: (BuildContext context) => NotesModel(),),
        ChangeNotifierProvider(create: (BuildContext context) => AppointmentsModel(),),
      ],
      child:  MaterialApp(
        title: "PIMBook",
        theme : PIMTheme.lightTheme,
        darkTheme: PIMTheme.darkTheme,
        themeMode: ThemeMode.system,//TODO : change Theme Manually
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: Text("PIMBook"),
 /*               leading: PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  onSelected: (int value){
                    currentThemeMode.toggleTheme();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  itemBuilder: (context)=>[
                    PopupMenuItem(value: 0,child: ListTile(title :Text("theme"),trailing: Icon(Icons.dark_mode_rounded)))
                  ],
                ),*/
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in,size: 20,),label: "Task",),
                  BottomNavigationBarItem(icon: Icon(Icons.sticky_note_2,size: 20),label: "Note",),
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
              body:
            //todo : tabs
            IndexedStack(
                index: _currentIndex,
                children: widget.tabs,
            ),
          ),
        ),
      ),
    );
  }
}



