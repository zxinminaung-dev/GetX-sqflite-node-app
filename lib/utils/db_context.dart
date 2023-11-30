import 'package:get/get.dart';
import 'package:hno_shopping_note/model/month.dart';
import 'package:hno_shopping_note/model/yeardata.dart';

import '../model/category.dart';
import '../model/task.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

import '../model/year.dart';

class DbContext {
  Database? _database;

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'store_db.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryId INTEGER,
        name TEXT,
        price INTEGER,
        quantity INTEGER,
        total INTEGER,
        date DATETIME
      )
    ''');
    await db.execute('''
      CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        monthId Integer,
        description TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE years(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        year INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE months(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        month TEXT,
        yearId INTEGER
      )
    ''');
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<List<Task>> fetchTasks(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> tasks =
        await db.query('tasks', where: 'categoryId = ?', whereArgs: [id]);
    return tasks.map((task) => Task.fromMap(task)).toList();
  }

  Future<List<Task>> fetchTasksByCategoryId(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> tasks =
        await db.query('tasks', where: 'categoryId = ?', whereArgs: [id]);
    return tasks.map((task) => Task.fromMap(task)).toList();
  }

  Future<int> insertTask(Task task) async {
    Database db = await database;
    return await db.rawInsert('''
      INSERT INTO tasks (name, categoryId, price, quantity,total)
      VALUES (?, ?, ?,?,?)
    ''', [task.name,task.categoryId, task.price, task.quantity, task.total]);
    //return await db.insert('tasks', task.toMap());
  }

  Future<int> updateTask(Task task) async {
    Database db = await database;
    return await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(int taskId) async {
    Database db = await database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
  }

  Future<Task?> getTaskById(int taskId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
    if (result.isNotEmpty) {
      return Task.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<List<Category>> getCateGoryList() async {
    Database db = await database;
    List<Map<String, dynamic>> categories = await db.query('categories');
    return categories.map((data) => Category.fromMap(data)).toList();
  }

  Future<List<Category>> getCateGoryListByMonthId(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> categories =
        await db.query('categories', where: 'monthId = ?', whereArgs: [id]);
    return categories.map((data) => Category.fromMap(data)).toList();
  }

  Future<int> updateCategory(Category category) async {
    Database db = await database;
    return await db.update('categories', category.toMap(),
        where: 'id = ?', whereArgs: [category.id]);
  }

  Future<int> insertCategory(Category category) async {
    Database db = await database;
    return await db.rawInsert('''
      INSERT INTO categories (name,monthId, description)
      VALUES (?, ?,?)
    ''', [category.name, category.monthId, category.description]);
    // return await db.insert('categories', category.toMap());
  }

  Future<int> deleteCategory(int categoryId) async {
    Database db = await database;
    return await db
        .delete('categories', where: 'id = ?', whereArgs: [categoryId]);
  }

  Future<Category?> getCategoryById(int catId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [catId],
    );
    if (result.isNotEmpty) {
      return Category.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<List<Year>> getYearList() async {
    Database db = await database;
    List<Map<String, dynamic>> years = await db.query('years');
    return years.map((year) => Year.fromMap(year)).toList();
  }

  Future<Year?> getByYearId(int year) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'years',
      where: 'id = ?',
      whereArgs: [year],
    );
    if (result.isNotEmpty) {
      return Year.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int> insertYear(Year year) async {
    Database db = await database;
    return await db.rawInsert('''
      INSERT INTO years (year)
      VALUES (?)
    ''', [year.year]);
  }

  Future<int> insertMonth(Months month) async {
    Database db = await database;
    return await db.rawInsert('''
      INSERT INTO months(month,yearId) VALUES(?,?)
    ''', [month.month, month.yearId]);
  }

  Future<int> deleteMonth(int id) async {
    Database db = await database;
    return await db.delete('months', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<YearData>> getYearDataList() async {
    List<YearData> list = [];
    Database db = await database;
    List<Map<String, dynamic>> years = await db.query('years');
    List<Year> year = years.map((year) => Year.fromMap(year)).toList();
    if (year.isNotEmpty) {
      for (var element in year) {
        List<Map<String, dynamic>> months = await db
            .query('months', where: 'yearId = ?', whereArgs: [element.id]);
        List<Months> month =
            months.map((month) => Months.fromMap(month)).toList();
        list.add(YearData(element, month, false.obs));
      }
    }
    Future<List<YearData>> data = Future.value(list);
    return data;
  }
}
