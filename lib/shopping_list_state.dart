part of 'shopping_list_cubit.dart';

enum DataProcessingState { noConnection, fetchingData, dataAccessed, idle }

class ShoppingListState {
  DatabaseController dbController = DatabaseController();
  DataProcessingState dataState = DataProcessingState.idle;
  List<ShoppingList> shoppingListData = [];

  ShoppingListState(this.dataState);

  void refreshData() async =>
      shoppingListData = await dbController.getShoppingLists();

  List<ShoppingList> getShoppingListData() {
    refreshData();
    return shoppingListData;
  }
}