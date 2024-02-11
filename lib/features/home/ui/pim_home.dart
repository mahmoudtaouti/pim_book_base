import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pim_book/core/theme/pim_icons.dart';
import 'package:pim_book/core/theme/pim_theme.dart';
import '../../../core/data/pim_db.dart';
import '../../../core/theme/color_themes.dart';
import '../../../core/theme/config.dart';
import '../../../core/utils.dart';
import '../../notes/ui/notes.dart';
import '../../reminders/ui/reminders.dart';
import '../../tasks/ui/tasks.dart';
import 'package:get/get.dart';
import '../application/pim_home_ctrl.dart';

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
  final PIMBookController controller = Get.put(PIMBookController());
  late final dbInit;
  @override
  void initState() {
    Utils.docsDir;
    currentThemeMode.addListener(() {
      setState(() {});
    });
    checkDB();
    super.initState();
  }

  checkDB()async{
    dbInit = await PIMdb.instance.init();
    if(dbInit.isLeft()){
      Get.snackbar('Failed to access Documents Directory', 'Not Found',margin: EdgeInsets.symmetric(vertical: 20,horizontal: 8));
    }
  }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: "PIMBook",
      //TODO : add more themes in premium version
      theme: PIMTheme.lightTheme,
      darkTheme: PIMTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Obx((){
          return Scaffold(
            appBar: AppBar(
              title: Text("PIMBook"),
              actions: [ PopupMenuButton(
                icon: PIMIcons.fromAsset(iconName: PIMIcons.settings,color: Get.theme.colorScheme.onSurface),
                onSelected: (int value) {
                  currentThemeMode.toggleTheme();
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 0,
                      child: ListTile(
                        title: Text("theme"),
                        trailing: Icon(Icons.dark_mode_rounded),
                      )),
                ],
              ),
              ]
            ),
            bottomNavigationBar: BottomBar(
              padding: EdgeInsets.all(20),
                items: [
                  BottomBarItem(
                      icon: PIMIcons.fromAsset(iconName: PIMIcons.note,color: Get.theme.colorScheme.onSurface),
                      title: Text("Tasks", style: Get.textTheme.labelLarge,),
                    activeColor:ColorThemes.lightColorScheme.primary,),
                  BottomBarItem(
                      icon: PIMIcons.fromAsset(iconName: PIMIcons.document_text,color: Get.theme.colorScheme.onSurface),
                      title: Text("Notes", style: Get.textTheme.labelLarge,),
                    activeColor:ColorThemes.lightColorScheme.primary,),
                  BottomBarItem(
                      icon: PIMIcons.fromAsset(iconName: PIMIcons.calendar,color: Get.theme.colorScheme.onSurface),
                      title: Text("Reminders", style: Get.textTheme.labelLarge,),
                      activeColor:ColorThemes.lightColorScheme.primary,
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
              children: widget.tabs,
            ),
          );
        }
      ),
    );
  }
}
