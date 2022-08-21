import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pim_book/core/theme/pim_theme.dart';
import 'core/Database.dart';
import 'core/theme/config.dart';
import 'features/events/ui/events.dart';
import 'features/notes/ui/notes.dart';
import 'features/tasks/ui/tasks.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(PIMBook());
}

class PIMBook extends StatefulWidget {
  PIMBook({Key? key}) : super(key: key);

  @override
  _PIMBookState createState() => _PIMBookState();
}

class _PIMBookState extends State<PIMBook> {

  int _currentIndex = 0;

  List<Widget> tabs = [
    Tasks(),
    Notes(),
    Events(),
    //Contacts(),
  ];

  @override
  void initState() {
    currentThemeMode.addListener(() {
      setState(() {});
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "PIMBook",
      theme : PIMTheme.lightTheme,
      darkTheme: PIMTheme.darkTheme,
      themeMode: ThemeMode.system,//TODO : change Theme Manually
      home: DefaultTabController(
        length: tabs.length+1,
        child: Scaffold(
            appBar: AppBar(
              title: Text("PIMBook"),
                leading: PopupMenuButton( //TODO : not working theme
                icon: Icon(Icons.more_vert),
                onSelected: (int value) async{
                  if(value == 0) {
                    currentThemeMode.toggleTheme();
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                  if(value == 1){
                    PIM_DB db = PIM_DB.instance;
                    await db.generateBackup(isEncrypted : true);
                    Get.snackbar(
                        'backups',
                        'Successfully created',
                        snackPosition: SnackPosition.TOP
                    );
                  }
                  if(value == 2){

                    PIM_DB db = PIM_DB.instance;
                    await db.clearAllTables();
                    await db.restoreBackup(isEncrypted : true);
                    Get.snackbar(
                        'backups',
                        'Successfully restored',
                        snackPosition: SnackPosition.TOP
                    );
                  }
                },
                itemBuilder: (context)=>[
                  PopupMenuItem(value: 0,child: ListTile(title :Text("theme"),trailing: Icon(Icons.dark_mode_rounded))),
                  PopupMenuItem(value: 1,child: ListTile(title :Text("create backup"),trailing: Icon(Icons.backup))),
                  PopupMenuItem(value: 2,child: ListTile(title :Text("restore"),trailing: Icon(Icons.settings_backup_restore)))
                ],
              ),
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
              children: tabs,
          ),
        ),
      ),
    );
  }
}





