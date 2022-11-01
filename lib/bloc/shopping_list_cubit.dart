import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_flutter/data/shopping_list_data.dart';
import 'package:to_do_flutter/data/database_controller.dart';
part 'package:to_do_flutter/bloc/shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  DatabaseController dbController = DatabaseController();
  ShoppingListCubit() : super(ShoppingListState());

  Future<void> getData() async {
    emit(ShoppingListState(
        shoppingListData: state.shoppingListData,
        dataState: DataProcessingState.fetchingData));
    final result = await dbController.getShoppingLists();
    if (result.isEmpty) {
      emit(ShoppingListState(
          dataState: DataProcessingState.idle, shoppingListData: result));
    } else {
      emit(ShoppingListState(
          dataState: DataProcessingState.dataAccessed,
          shoppingListData: result));
    }
  }

  Future<void> addList() async {
    dbController.insertList(ShoppingList(title: "New List"));
    final result = await dbController.getShoppingLists();
    emit(ShoppingListState(
        dataState: DataProcessingState.dataAccessed, shoppingListData: result));
  }

  Future<void> deleteShoppingList(int index) async {
    dbController.deleteShoppingList(index);
    final result = await dbController.getShoppingLists();
    emit(ShoppingListState(
        dataState: DataProcessingState.dataAccessed, shoppingListData: result));
  }
}