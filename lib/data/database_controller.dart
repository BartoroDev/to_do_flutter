import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_flutter/data/shopping_list_data.dart';

class DatabaseController {
  DatabaseController._internal();
  factory DatabaseController() => _controller;

  static final DatabaseController _controller = DatabaseController._internal();
  late final Database database;

  Future<void> init() async => database = await openDatabase(
        join(await getDatabasesPath(), 'shoppingApp.db'),
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE shoppingList(id INTEGER PRIMARY KEY, title TEXT)');
          await db.execute(
              'CREATE TABLE productList(id INTEGER PRIMARY KEY, listId INTEGER, isChecked BOOL, name TEXT)');
        },
        version: 1,
      );

  Future<int> insertList(ShoppingList list) async =>
      database.insert('shoppingList', list.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);

  Future<void> updateListTitle(int id, String title) async => database
      .rawUpdate("UPDATE shoppingList SET title = '$title' WHERE id = '$id'");

  Future<List<ShoppingList>> getShoppingLists() async {
    final List<Map<String, dynamic>> shoppingListsMap =
        await database.query('shoppingList');
    return List.generate(
        shoppingListsMap.length,
        (index) => ShoppingList(
            id: shoppingListsMap[index]['id'],
            title: shoppingListsMap[index]['title']));
  }

  Future<void> deleteShoppingList(int id) async {
    await database.delete('shoppingList', where: 'id = ?', whereArgs: [id]);
    await database.delete('productList', where: 'listId = ?', whereArgs: [id]);
  }

  Future<int> insertProduct(ProductData product) async =>
      database.insert('productList', product.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);

  Future<void> updateProductCheck(int id, int isChecked) async =>
      database.rawUpdate(
          "UPDATE productList SET isChecked = '$isChecked' WHERE id = '$id'");

  Future<void> updateProductName(int id, String name) async => database
      .rawUpdate("UPDATE productList SET name = '$name' WHERE id = '$id'");

  Future<ProductData> getOneProduct(int productId) async {
    final List<Map<String, dynamic>> productMap = await database
        .query('productList', where: 'id = ?', whereArgs: [productId]);

    return ProductData(
        id: productMap[0]['id'],
        listId: productMap[0]['listId'],
        isChecked: productMap[0]['isChecked'],
        name: productMap[0]['name']);
  }

  Future<List<ProductData>> getProducts(int listId) async {
    final List<Map<String, dynamic>> productMap = await database
        .query('productList', where: 'listId = ?', whereArgs: [listId]);
    return List.generate(
        productMap.length,
        (index) => ProductData(
            id: productMap[index]['id'],
            listId: productMap[index]['listId'],
            isChecked: productMap[index]['isChecked'],
            name: productMap[index]['name']));
  }

  Future<void> deleteProduct(int id) async =>
      database.delete('productList', where: 'id = ?', whereArgs: [id]);
}