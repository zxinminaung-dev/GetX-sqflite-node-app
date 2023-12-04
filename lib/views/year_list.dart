import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hno_shopping_note/controller/year_controller.dart';
import 'package:hno_shopping_note/model/month.dart';
import 'package:hno_shopping_note/model/year.dart';
import 'package:hno_shopping_note/model/yeardata.dart';

// ignore: must_be_immutable
class YearList extends GetView<YearController> {
  YearList({Key? key}) : super(key: key);
  //YearController controller = Get.find();
  final TextEditingController _monthContoller =  TextEditingController();
  final TextEditingController _yearTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        title: const Text(
          'Note App',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Obx(() => SingleChildScrollView(
              child: ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: const EdgeInsets.all(0),
            children:
                controller.yearDataList.map<ExpansionPanel>((YearData year) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                      leading: Wrap(
                        spacing: 0.0,
                        children: [
                          GestureDetector(
                            onTap: (){
                                _showDeleteYearDialog(year.year!);
                            },
                            child: const Padding(
                              padding:  EdgeInsets.only(right: 0.0),
                              child:  Icon(Icons.delete,
                                  color: Colors.red,size: 26,),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                                _showAddMonthDialog(year.year!.id!);
                            },
                            child: const Padding(
                              padding:  EdgeInsets.only(left: 5.0),
                              child:  Icon(Icons.create_new_folder_sharp,
                                  color: Colors.cyan,size: 26,),
                            ),
                          ),
                        ],
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${year.year!.year}',style:const TextStyle(color: Colors.cyan),),
                          // Container(
                          //   margin: EdgeInsets.only(left: 0),
                          //   color:Colors.cyan,
                          //   height: 0.6,
                          // ) ,   
                        ],
                      ),
                    );
                },
                body: Column(
                  children: year.months
                      .map<Widget>((Months month) => Column(
                        children: [     
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            color:Colors.cyan,
                            height: 0.6,
                          ) ,                    
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: ListTile(     
                              onTap: (){
                                Get.toNamed('/category',arguments: [month.month,year.year!.id,month.id]);
                              },                         
                              leading: const Icon(Icons.arrow_right_outlined,size: 25,),
                                  title: Text('${month.month}',style: const TextStyle(fontSize: 14,color: Colors.cyan),),
                                  trailing: InkWell(onTap: (){
                                    _showDeleteDialog(month);
                                  },child: const Icon(Icons.delete,color: Colors.red,size: 20,)),
                                ),
                          ),
                        ],
                      ))
                      .toList(),
                ),
                isExpanded: year.isExpanded.isTrue ? true : false,
                canTapOnHeader: true,
              );
            }).toList(),            
             expansionCallback: (int index,bool isExpanded){              
              controller.changeExpanded(index);
             },
          ))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          _showAddDialog();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
  _showDeleteYearDialog(Year year){
    Get.defaultDialog(      
      titleStyle: const TextStyle(fontSize: 16, color: Colors.amber),
      title: 'Delete Alert',
      content: Text('Are you sure to delete${year.year} ?'),
      actions: [
         TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {    
              controller.deleteYear(year); 
              controller.fetchDataList();       
              Get.back();
            },
            child: const Text('Delete',style: TextStyle(color: Colors.red),),
          ),
      ]
    );
  }
 _showDeleteDialog(Months month) {
    Get.defaultDialog(
        titleStyle: const TextStyle(fontSize: 16, color: Colors.amber),
        title: 'Delete Alert',
        content: Text('Are you sure to delete ${month.month}?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {    
              controller.deleteMonth(month); 
              controller.fetchDataList();       
              Get.back();
            },
            child: const Text('Delete',style: TextStyle(color: Colors.red),),
          ),
        ]);
  }
  _showAddDialog() {
    Get.defaultDialog(
        title: 'Year Folder',
        titleStyle: const TextStyle(color: Colors.cyan, fontSize: 16),
        content: Column(
          children: [
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 10,right: 10),
              child: TextField(
                controller: _yearTextController,
                decoration: const InputDecoration(
                   border:OutlineInputBorder(),
                    labelText: 'Folder Name',
                    labelStyle:
                        TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _yearTextController.clear();
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Year year =
                  Year(id: 0, year: int.parse(_yearTextController.text));
              controller.addYear(year);
              controller.fetchDataList();
              _yearTextController.clear();
              Get.back();
            },
            child: const Text('Save'),
          ),
        ]);
  }

  _showAddMonthDialog(int yearId) {
    Get.defaultDialog(
        title: 'Child Folder',
        titleStyle: const TextStyle(color: Colors.cyan, fontSize: 16),
        content: Column(
          children: [
            Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left:10.0,right: 10.0),
                child: TextField(
                  controller: _monthContoller,
                  decoration: const InputDecoration(
                      labelText: 'Folder Name',
                      border:OutlineInputBorder(),
                      labelStyle:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _monthContoller.clear();
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Months months =
                  Months(id: 0,month: _monthContoller.text, yearId: yearId);
                  controller.addMonth(months);
                  controller.fetchDataList();
                  _monthContoller.clear();
              Get.back();
            },
            child: const Text('Save'),
          ),
        ]);
  }
}
