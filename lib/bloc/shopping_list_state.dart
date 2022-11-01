part of 'shopping_list_cubit.dart';

class ShoppingListState {
  final DataProcessingState dataState;
  final List<ShoppingList> shoppingListData;

  ShoppingListState(
      {this.dataState = DataProcessingState.idle,
      this.shoppingListData = const []});
}