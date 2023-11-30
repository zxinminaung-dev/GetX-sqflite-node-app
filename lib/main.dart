import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hno_shopping_note/binding/task_binding.dart';
import 'package:hno_shopping_note/binding/year_binding.dart';
// import 'package:hno_shopping_note/views/task_entry.dart';
import 'package:hno_shopping_note/views/tasks_list.dart';
import 'package:hno_shopping_note/views/year_list.dart';

import 'binding/category_binding.dart';
import 'views/category_list.dart';

void main() {
  runApp(
    GetMaterialApp(
      navigatorKey: Get.key,
      initialRoute: '/',
      getPages: [        
        GetPage(
          name: '/category',
          page: () => CategoryList(),
          binding: CategoryBindings(), // Assign the binding to the route
        ),
        GetPage(
          name: '/',
          page: () => YearList(),
          binding: YearBindings(), // Assign the binding to the route
        ),
         GetPage(
          name: '/task',
          page: () => TaskList(),
          binding: TaskBinding(), // Assign the binding to the route
        ),
        //  GetPage(
        //   name: '/task-entry',
        //   page: () => TaskEntry(),
        //   binding: TaskBinding(), // Assign the binding to the route
        // ),
      ],
    ),
  );
}
