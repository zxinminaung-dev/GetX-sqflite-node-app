
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hno_shopping_note/controller/task_controller.dart';

import '../model/task.dart';

// ignore: must_be_immutable
class TaskEntry extends GetView<TaskController> {
   TaskEntry({super.key,required this.categoryId});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController= TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
   final TextEditingController _totalController = TextEditingController();
  int categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
         leading: IconButton(onPressed: (){
          Get.back();
        }, icon:const Icon(Icons.arrow_back_ios,size: 19,color: Colors.white,)),
        title:const Text('Note Entry',style: TextStyle(color: Colors.white,fontSize: 18)),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.only(left:12.0,right: 12.0),
          child: Column(
            children: [
              TextField(
                  controller: _nameController,              
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                ),
                TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                      labelText: 'Price',
                      labelStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                ),
                 TextField(
                  controller: _quantityController,
                  onChanged: (val){
                    _totalController.text=(int.parse(_priceController.text)* int.parse(_quantityController.text)).toString();
                  },
                  decoration: const InputDecoration(
                      labelText: 'Quantity',
                      labelStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                ),
                 TextField(
                  controller: _totalController,     
                  enabled: false,             
                  decoration: const InputDecoration(
                      labelText: 'Total',
                      labelStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(onPressed: (){
                      Get.back();
                    }, child: const Text('Cancel')),
                     TextButton(onPressed: (){
                      int price = int.parse(_priceController.text);
                      int quantity = int.parse(_quantityController.text);
          
                      int total = price * quantity;
                      Task task = Task(id: 0,name: _nameController.text, price: price,quantity: quantity,total: total,categoryId: categoryId);
                      controller.addTask(task);
                      Get.back();
                     }, child: const Text('Save'))
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}