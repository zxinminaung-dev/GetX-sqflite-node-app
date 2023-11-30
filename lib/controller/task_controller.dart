
import 'package:get/get.dart';
import '../Utils/db_context.dart';
import '../model/task.dart';

class TaskController extends GetxController {
  final DbContext context = DbContext();
  RxList<Task> tasks = <Task>[].obs;
  RxInt total = 0.obs;
  Future<void> fetchTasksByCategoryId(int id) async {
    tasks.assignAll(await context.fetchTasksByCategoryId(id));
    total=0.obs;
    for (var data in tasks){
      total += data.total!;
    }
   // print(tasks);
    update();
  }

  Future<int> addTask(Task? tasks) async {
    int id = 0;
    if (tasks != null) {
      Task newTask = Task(
          id: null,
          categoryId: tasks.categoryId,
          name: tasks.name,
          price: tasks.price,
          quantity: tasks.quantity,
          total: tasks.total,
          );
      id = await context.insertTask(newTask);
    }
    return id;
  }
  Future<int> deleteTask(Task task)async{
    int id=0;
    id=await context.deleteTask(task.id!);
    return id;
  }
}