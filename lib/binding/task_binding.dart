import 'package:get/get.dart';
import '../controller/task_controller.dart';
class TaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController());
  }
}