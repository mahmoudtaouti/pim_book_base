import 'package:get/get.dart';

class PIMBookController extends GetxController {

  var _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  set currentIndex(int value) {
    _currentIndex.value = value;
    this.update();
  }
}