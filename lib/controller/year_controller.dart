import 'package:get/get.dart';
import 'package:hno_shopping_note/model/month.dart';
import 'package:hno_shopping_note/utils/db_context.dart';

import '../model/year.dart';
import '../model/yeardata.dart';

class YearController extends GetxController {
  RxList<YearData> yearDataList = <YearData>[].obs;
  final DbContext context = DbContext();
  RxInt index = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataList();
  }

  Future<void> fetchDataList() async {
    yearDataList.assignAll(await context.getYearDataList());
    update();
  }

  Future<int> addYear(Year? year) async {
    int id = 0;
    if (year != null) {
      id = await context.insertYear(year);
    }
    return id;
  }
  Future<int> deleteYear(Year year) async{
    int id = 0;
    try{
      id = await context.deleteYear(year.id!);
      // if(id>0){
      //   List<Months> months= await context.getMonthsByYearId(id);
      //   for (var data in months){
      //      late int res;
      //      res= await context.deleteMonth(data.id!);
      //       print(res);
      //   }
      // }
    }catch(err){

    }
    return id;
  }
  void changeExpanded(int index) {
    if (yearDataList[index].months.isNotEmpty) {
      if (yearDataList[index].isExpanded.value) {
        yearDataList[index].isExpanded = false.obs;
      } else {
        yearDataList[index].isExpanded = true.obs;
      }
      yearDataList.refresh();
      update();
    }
  }
    void changeExpandedById(int yearId) {
    yearDataList.where((x) => x.year!.id==yearId).first.isExpanded=true.obs;
    yearDataList.refresh();
  }
  Future<int> addMonth(Months? month) async {
    int id = 0;
    if (month != null) {
      id = await context.insertMonth(month);
    }
    return id;
  }
  Future<int> deleteMonth(Months? months)async{
    int id= 0;
    if(months!=null){
      id = await context.deleteMonth(months.id!);
    }
    return id;
  }
}
