import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_flutter/data/shopping_list_data.dart';

class DatabaseController {
  Future<Database> database() async {
    WidgetsFlutterBinding.ensureInitialized();

    return openDatabase(
      join(await getDatabasesPath(), 'shoppingApp.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE shoppingList(id INTEGER PRIMARY KEY, title TEXT)');
        await db.execute(
            'CREATE TABLE productList(id INTEGER PRIMARY KEY, listId INTEGER, isChecked BOOL, name TEXT)');

        return;
      },
      version: 1,
    );
  }

  Future<int> insertList(ShoppingList list) async {
    int listId = 0;
    Database db = await database();
    listId = await db
        .insert('shoppingList', list.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) => listId = value);
    return listId;
  }

  Future<void> updateListTitle(int id, String title) async {
    Database db = await database();
    await db
        .rawUpdate("UPDATE shoppingList SET title = '$title' WHERE id = '$id'");
  }

  Future<List<ShoppingList>> getShoppingLists() async {
    Database db = await database();
    final List<Map<String, dynamic>> shoppingListsMap =
        await db.query('shoppingList');
    return List.generate(shoppingListsMap.length, (index) {
      return ShoppingList(
          id: shoppingListsMap[index]['id'],
          title: shoppingListsMap[index]['title']);
    });
  }

  Future<void> deleteShoppingList(int id) async {
    Database db = await database();
    await db.delete('shoppingList', where: 'id = ?', whereArgs: [id]);
    await db.delete('productList', where: 'listId = ?', whereArgs: [id]);
  }

  Future<int> insertProduct(ProductData product) async {
    int productId = 0;
    Database db = await database();
    await db
        .insert('productList', product.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) => productId = value);
    return productId;
  }

  Future<void> updateProductCheck(int id, int isChecked) async {
    Database db = await database();
    await db.rawUpdate(
        "UPDATE productList SET isChecked = '$isChecked' WHERE id = '$id'");
  }

  Future<void> updateProductName(int id, String name) async {
    Database db = await database();
    await db
        .rawUpdate("UPDATE productList SET name = '$name' WHERE id = '$id'");
  }

  Future<ProductData> getOneProduct(int productId) async {
    Database db = await database();
    final List<Map<String, dynamic>> productMap =
        await db.query('productList', where: 'id = ?', whereArgs: [productId]);

    return ProductData(
        id: productMap[0]['id'],
        listId: productMap[0]['listId'],
        isChecked: productMap[0]['isChecked'],
        name: productMap[0]['name']);
  }

  Future<List<ProductData>> getProducts(int listId) async {
    Database db = await database();
    final List<Map<String, dynamic>> productMap =
        await db.query('productList', where: 'listId = ?', whereArgs: [listId]);
    return List.generate(productMap.length, (index) {
      return ProductData(
          id: productMap[index]['id'],
          listId: productMap[index]['listId'],
          isChecked: productMap[index]['isChecked'],
          name: productMap[index]['name']);
    });
  }

  Future<void> deleteProduct(int id) async {
    Database db = await database();
    await db.delete('productList', where: 'id = ?', whereArgs: [id]);
  }
}