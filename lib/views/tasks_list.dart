import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hno_shopping_note/controller/task_controller.dart';

import '../model/task.dart';

// ignore: must_be_immutable
class TaskList extends StatelessWidget {
  TaskList({super.key});
  final int catId = int.parse(Get.arguments[0].toString());
  TaskController controller = Get.put(TaskController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  int count = 0;
  @override
  Widget build(BuildContext context) {
    controller.fetchTasksByCategoryId(catId);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 19,
                color: Colors.white,
              )),
          centerTitle: true,
          title: const Text('Note List',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          actions: [
            IconButton(
                onPressed: () {
                  _showNoteDialog(context);
                },
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ))
          ],
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.cyan),
                    columnWidths: const {
                      0: FlexColumnWidth(
                          2.0), // Adjust column width for the first column
                      1: FlexColumnWidth(3.0),
                      2: FlexColumnWidth(2.0),
                      3: FlexColumnWidth(2.0),
                      4: FlexColumnWidth(
                          2.0), // Adjust column width for the third column
                    },
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(color: Colors.cyan),
                        children: [
                          TableCell(
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                              child: Text('Action',
                                  style: TextStyle(color: Colors.white)),
                            )),
                          ),
                          TableCell(
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                              child: Text('Name',
                                  style: TextStyle(color: Colors.white)),
                            )),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                              child: Center(
                                  child: Text('Price',
                                      style: TextStyle(color: Colors.white))),
                            ),
                          ),
                          TableCell(
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                              child: Text('Quantity',
                                  style: TextStyle(color: Colors.white)),
                            )),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                              child: Center(
                                  child: Text('Total',
                                      style: TextStyle(color: Colors.white))),
                            ),
                          ),
                        ],
                      ),
                      for (var task in controller.tasks)
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.only(top:2.0,bottom: 2.0),
                                child: Center(child: InkWell(
                                  onTap: (){
                                    _showDeleteDialog(task);
                                  },
                                  child: const Center(
                                    child: Icon(Icons.delete,size: 20,color: Colors.red,),
                                  ),
                                )),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.only(top:2.0,bottom: 2.0,left: 3.0),
                                child: Text('${task.name}'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.only(top:2.0,bottom: 2.0),
                                child: Center(child: Text('${task.price}')),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.only(top:2.0,bottom: 2.0),
                                child: Center(child: Text('${task.quantity}')),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                               padding: const EdgeInsets.only(top:2.0,bottom: 2.0),
                                child: Center(child: Text('${task.total}')),
                              ),
                            ),
                          ],
                        ),
                      TableRow(
                        children: [
                          const TableCell(
                            child: Center(child: Text('')),
                          ),
                          const TableCell(
                            child: Padding(
                              padding: EdgeInsets.only(left:3.0),
                              child: Text('total'),
                            ),
                          ),
                          const TableCell(
                            child: Center(child: Text('')),
                          ),
                          const TableCell(
                            child: Center(child: Text('')),
                          ),
                          TableCell(
                            child: Center(child: Text('${controller.total}')),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
 _showDeleteDialog(Task task) {
    Get.defaultDialog(
        titleStyle: const TextStyle(fontSize: 16, color: Colors.amber),
        title: 'Delete Alert',
        content: Text('Are you sure to delete ${task.name}?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {    
              controller.deleteTask(task); 
              controller.fetchTasksByCategoryId(catId);       
              Get.back();
            },
            child: const Text('Delete',style: TextStyle(color: Colors.red),),
          ),
        ]);
  }
  void _showNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  decoration: const InputDecoration(
                      labelText: 'Price',
                      labelStyle:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _quantityController,
                  onChanged: (val) {
                    int price = 1;
                    if (val.isEmpty) {
                      price = 1;
                    } else {
                      if (_priceController.text.isNotEmpty) {
                        price = int.parse(_priceController.text);
                      }
                      _totalController.text =
                          (price * int.parse(val)).toString();
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: 'Quantity',
                      labelStyle:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                ),
                TextField(
                  controller: _totalController,
                  enabled: false,
                  decoration: const InputDecoration(
                      labelText: 'Total',
                      labelStyle:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          int price = int.parse(_priceController.text);
                          int quantity = int.parse(_quantityController.text);

                          int total = price * quantity;
                          Task task = Task(
                              id: 0,
                              name: _nameController.text,
                              price: price,
                              quantity: quantity,
                              total: total,
                              categoryId: catId);
                          controller.addTask(task);
                          _nameController.clear();
                          _priceController.clear();
                          _quantityController.clear();
                          _totalController.clear();
                          controller.fetchTasksByCategoryId(catId);
                          Get.back();
                        },
                        child: const Text('Save'))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
