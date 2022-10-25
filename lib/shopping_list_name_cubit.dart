import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shopping_list_name_state.dart';

class ShoppingListNameCubit extends Cubit<ShoppingListNameState> {
  ShoppingListNameCubit()
      : super(ShoppingListNameState(name: "Shopping List!"));
  void changeName(String newName) => emit(ShoppingListNameState(name: newName));
}