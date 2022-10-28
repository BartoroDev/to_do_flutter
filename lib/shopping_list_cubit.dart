import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'data/shopping_list_data.dart';
import 'data/database_controller.dart';
part 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  ShoppingListCubit() : super(ShoppingListState(DataProcessingState.idle));

  void getData() async {
    emit(ShoppingListState(DataProcessingState.fetchingData));
    state.refreshData();
    if (state.getShoppingListData() == []) {
      emit(ShoppingListState(DataProcessingState.idle));
    } else {
      emit(ShoppingListState(DataProcessingState.dataAccessed));
    }
  }

  void addList() async {
    state.dbController.insertList(ShoppingList(title: "New List"));
    state.refreshData();
    emit(ShoppingListState(DataProcessingState.dataAccessed));
  }

  void deleteShoppingList(int index) async {
    state.dbController.deleteShoppingList(index);
    state.refreshData();
    emit(ShoppingListState(DataProcessingState.dataAccessed));
  }
}