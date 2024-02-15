import 'package:get/get.dart';
import 'package:pim_book/features/reminders/data/reminders_db_worker.dart';
import '../domain/reminder.dart';

class RemindersController extends GetxController {
  RemindersDBWorker remindersDBWorker = RemindersDBWorker();
  var _reminders = <Reminder>[].obs;
  var _remindersOfSelectedDate = <Reminder>[].obs;
  var _selectedDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,0,0,0,0,0).millisecondsSinceEpoch.obs;


  @override
  void onInit() async {
    await fetchData();
    setRemindersOfSelectedDate();
    super.onInit();
  }

  set selectedDate(DateTime dateTime) {
    _selectedDate.value = dateTime.millisecondsSinceEpoch;
    setRemindersOfSelectedDate();
  }

  DateTime get selectedDate =>
      DateTime.fromMillisecondsSinceEpoch(_selectedDate.value);

  ///TODO
  setRemindersOfSelectedDate(){
    _remindersOfSelectedDate.clear();
    _reminders.forEach((element) {
      if (_selectedDate.value == element.date) {
        _remindersOfSelectedDate.add(element);
      }
    });
  }

  List<Reminder> get remindersOfSelectedDate => _remindersOfSelectedDate;

  List<Reminder> get reminders => _reminders;

  Future<void> fetchData() async {
    try {
      List<Reminder> reminders = await remindersDBWorker.getAllDescendant();
      _reminders.clear();
      _reminders.addAll(reminders);
      setRemindersOfSelectedDate();
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  void deleteThisReminder(Reminder reminder) async {
    _reminders.remove(reminder);
    _remindersOfSelectedDate.remove(reminder);
    await remindersDBWorker.delete(reminder.id!);
    Get.showSnackbar(GetSnackBar(
      title: 'Reminder Deleted',
      message: 'Task: ${reminder.title}',
      duration: Duration(seconds: 1),
    ));
  }
}
