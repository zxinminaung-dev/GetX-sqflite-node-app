import 'package:get/get.dart';
import 'package:hno_shopping_note/model/month.dart';
import 'package:hno_shopping_note/model/year.dart';

class YearData{
  Year? year;
  List<Months> months;
  RxBool isExpanded;
  YearData(this.year,this.months,this.isExpanded);
}