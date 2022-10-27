import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'data/shopping_list_data.dart';
import 'data/database_controller.dart';
part 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  DatabaseController dbController = DatabaseController();
  List<ShoppingList> ShoppingListData = [];

  ShoppingListCubit() : super(ShoppingListState(DataProcessingState.idle));

  void getData() async {
    emit(ShoppingListState(DataProcessingState.fetchingData));
    ShoppingListData = await dbController.getShoppingLists();
    if (ShoppingListData == []) {
      emit(ShoppingListState(DataProcessingState.idle));
    } else {
      emit(ShoppingListState(DataProcessingState.dataAccessed));
    }
  }

  void addList() async =>
      dbController.insertList(ShoppingList(title: "New List"));
}