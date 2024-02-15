import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pim_book/core/theme/pim_icons.dart';
import 'package:pim_book/core/theme/pim_theme.dart';
import 'package:pim_book/features/notes/application/notes_ctrl.dart';
import 'package:pim_book/features/tasks/application/tasks_ctrl.dart';
import '../../../core/data/pim_db.dart';
import '../../../core/utils.dart';
import '../../notes/ui/notes.dart';
import '../../reminders/application/reminders_ctrl.dart';
import '../../reminders/ui/reminders.dart';
import '../../settings/ui/settings_page.dart';
import '../../tasks/ui/tasks.dart';
import 'package:get/get.dart';
import '../application/pim_home_ctrl.dart';

class PIMBook extends StatefulWidget {
  PIMBook({Key? key}) : super(key: key);

  @override
  _PIMBookState createState() => _PIMBookState();
}

class _PIMBookState extends State<PIMBook> {
  late final PIMBookController controller;
  late final dbInit;
  late final List<Widget> tabs;

  _initCTRLs() {
    controller = Get.put(PIMBookController());
    Get.lazyPut(() =>TasksController());
    Get.lazyPut(()=>NotesController());
    Get.lazyPut(()=>RemindersController());
  }


  checkDB() async {
    dbInit = await PIMdb.instance.init();
    if(dbInit.isLeft()){
      Get.snackbar('Failed to access Documents Directory', 'Not Found',margin: EdgeInsets.symmetric(vertical: 20,horizontal: 8));
    }
  }

  @override
  void initState() {
    Utils.docsDir;
    checkDB();
    _initCTRLs();
    tabs = [
      Tasks(key: GlobalKey(),),
      Notes(key: GlobalKey(),),
      Reminders(key: GlobalKey(),),
      //Contacts(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "PIMBook",
      //TODO : add more themes in premium version
      theme: PIMTheme.lightTheme,
      darkTheme: PIMTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Obx((){
          return PopScope(
            canPop: false,
            child: Scaffold(
              appBar: AppBar(
                title: Text("PIMBook"),
                actions: [ IconButton(
                  icon: PIMIcons.fromAsset(iconName: PIMIcons.settings,color: Get.theme.colorScheme.onSurface),
                  onPressed: () => Get.to(SettingsPage()),),
                ],
                forceMaterialTransparency: true,
              ),
              bottomNavigationBar: BottomBar(
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.all(20),
                  items: [
                    BottomBarItem(
                        icon: PIMIcons.fromAsset(iconName: PIMIcons.note,color: Get.theme.colorScheme.onSurface),
                        title: Text("Tasks", style: Get.textTheme.labelLarge,),
                      activeColor: Get.theme.colorScheme.onSurfaceVariant),
                    BottomBarItem(
                        icon: PIMIcons.fromAsset(iconName: PIMIcons.document_text,color: Get.theme.colorScheme.onSurface),
                        title: Text("Notes", style: Get.textTheme.labelLarge,),
                      activeColor: Get.theme.colorScheme.onSurfaceVariant,),
                    BottomBarItem(
                        icon: PIMIcons.fromAsset(iconName: PIMIcons.calendar,color: Get.theme.colorScheme.onSurface),
                        title: Text("Reminders", style: Get.textTheme.labelLarge,),
                        activeColor: Get.theme.colorScheme.onSurfaceVariant,
                        ),
                    // BottomNavigationBarItem(icon: Icon(Icons.contacts,size: 20),label: "Contact",),
                  ],
                  onTap: (int index) {
                    controller.currentIndex = index;
                  },
                  selectedIndex: controller.currentIndex,
                //currentIndex: controller.currentIndex,
              ),
              body: IndexedStack(
                index: controller.currentIndex,
                children: tabs,
              ),
            ),
          );
        }
      ),
    );
  }
}
