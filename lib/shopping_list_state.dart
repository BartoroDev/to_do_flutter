part of 'shopping_list_cubit.dart';

enum DataProcessingState { noConnection, fetchingData, dataAccessed, idle }

class ShoppingListState {
  DataProcessingState dataState = DataProcessingState.idle;

  ShoppingListState(this.dataState);
}