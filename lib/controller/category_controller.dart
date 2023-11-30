
// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

import '../model/category.dart';
import '../utils/db_context.dart';

class CategoryController extends GetxController {
  RxList<Category> list = <Category>[].obs;
  final DbContext context = DbContext();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchCategories(int id) async {
    list.assignAll(await context.getCateGoryListByMonthId(id));
    list.refresh();
    update();
  }

  Future<int> addCategory(Category? category) async {
    int id = 0;
    if (category != null) {
      Category cat = Category(
        id: 0,
        name: category.name,
        monthId: category.monthId,
        description: category.description,
      );
      id = await context.insertCategory(cat);
      //print(id);
    }
    return id;
  }
  Future<int> deleteCategory(Category? category)async{
    int id=0;
    if(category!=null){
      id=await context.deleteCategory(category.id!);
    }
    return id;
  }
    Future<int> updateCategory(Category? category)async{
    int id=0;
    if(category!=null){
      id=await context.updateCategory(category);
    }
    return id;
  }
}
