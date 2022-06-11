class ShoppingList {
  final int? id;
  String title;

  ShoppingList({this.id, required this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}

class ProductData {
  final int? id;
  final int listId;
  int isChecked;
  String name;

  ProductData(
      {this.id,
      required this.listId,
      required this.name,
      required this.isChecked});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'listId': listId,
      'isChecked': isChecked,
      'name': name,
    };
  }
}