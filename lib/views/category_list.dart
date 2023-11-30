import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/category_controller.dart';
import '../model/category.dart';

// ignore: must_be_immutable
class CategoryList extends StatelessWidget {
  CategoryList({Key? key}): super(key: key);
  final String monthname=Get.arguments[0].toString();
  final int monthId = int.parse(Get.arguments[2].toString());
  CategoryController categoryController = Get.put(CategoryController());
  final TextEditingController _monthTextController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _catDecController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    categoryController.fetchCategories(monthId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon:const Icon(Icons.arrow_back_ios,size: 19,color: Colors.white,)),
        centerTitle: true,
        title: Text(
          'Category List ( $monthname )',
          style:const TextStyle(color: Colors.white,fontSize: 18),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: categoryController.list.length,
          itemBuilder: (context, index) {
            Category category = categoryController.list[index];
            return Container(
              padding: const EdgeInsets.all(0.0),
              margin: const EdgeInsets.all(3.0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              child: Card(
                child: ListTile(
                  onTap: (){
                    Get.toNamed('/task',arguments: [category.id]); 
                  },
                  subtitle: category.description == null ? const Text('') :Text(category.description!,style: const TextStyle(color: Colors.cyan),) ,
                  title: Text(
                    category.name!,
                    style: const TextStyle(color: Colors.cyan),
                  ),
                  trailing: const Icon(Icons.arrow_right_rounded),
                  leading: Wrap(
                    spacing: 0,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:3.0),
                        child: InkWell(
                          onTap: () {
                            _showEditDialog(category);
                          },
                          child: const Icon(Icons.edit_note,size: 30, color: Colors.amber),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showDeleteDialog(category);
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          _showAddCategoryDialog();
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
  void _showEditDialog(Category category){
    _categoryController.text=category.name!;
    //_monthTextController.text=monthname;
    _catDecController.text=category.description ==null ? '' : category.description! ;
    Get.defaultDialog(
        title: 'Edit Category',
        titleStyle: const TextStyle(color: Colors.black, fontSize: 16),
        content: Column(
          children: [
          //   TextField(
          //   controller: _monthTextController,
          //   enabled: false,
          //   decoration: const InputDecoration(
          //       labelText: 'Month',
          //       labelStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
          // ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                  labelText: 'Category Title',
                  labelStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
            ),
            TextField(
              controller: _catDecController,
              decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _categoryController.clear();
              _catDecController.clear();
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
               category = Category(
                  id: category.id, name: _categoryController.text, monthId: monthId ,description: _catDecController.text);
              //categoryController.(category);
              categoryController.updateCategory(category);
              categoryController.fetchCategories(monthId);
              _categoryController.clear();
              _catDecController.clear();
              Get.back();
            },
            child: const Text('Save'),
          ),
        ]);
  }
  void _showDeleteDialog(Category category) {
    Get.defaultDialog(
        titleStyle: const TextStyle(fontSize: 16, color: Colors.amber),
        title: 'Delete Alert',
        content: Text('Are you sure to delete ${category.name}?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {            
              categoryController.deleteCategory(category);
              categoryController.fetchCategories(monthId);
              _categoryController.clear();
              _catDecController.clear();
              Get.back();
            },
            child: const Text('Delete'),
          ),
        ]);
  }

  void _showAddCategoryDialog() {
    _monthTextController.text=monthname;
    Get.defaultDialog(
        title: 'Add Category',
        titleStyle: const TextStyle(color: Colors.black, fontSize: 16),
        content: Column(
          children: [
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                  labelText: 'Category Title',
                  labelStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
            ),
            TextField(
              controller: _catDecController,
              decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _categoryController.clear();
              _catDecController.clear();
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Category category = Category(
                  id: null, name: _categoryController.text,monthId: monthId ,description: _catDecController.text);
              categoryController.addCategory(category);
              categoryController.fetchCategories(monthId);
              _categoryController.clear();
              _categoryController.clear();
              Get.back();
            },
            child: const Text('Save'),
          ),
        ]);
  }
}
