
import 'package:get/get.dart';
import 'package:hno_shopping_note/controller/year_controller.dart';

class YearBindings extends Bindings{
    @override
  void dependencies() {
    Get.lazyPut<YearController>(() => YearController());
  }
}