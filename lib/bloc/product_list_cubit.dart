import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/shopping_list_data.dart';
import 'package:to_do_flutter/data/database_controller.dart';
part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  DatabaseController dbController = DatabaseController();
  int listId;
  ProductListCubit({required this.listId}) : super(ProductListState());

  Future<void> getData() async {
    emit(ProductListState(
        productListData: state.productListData,
        dataState: DataProcessingState.fetchingData));
    final result = await dbController.getProducts(listId);
    if (result.isEmpty) {
      emit(ProductListState(
          dataState: DataProcessingState.idle, productListData: result));
    } else {
      emit(ProductListState(
          dataState: DataProcessingState.dataAccessed,
          productListData: result));
    }
  }

  Future<void> addProduct(ProductData product) async {
    dbController.insertProduct(product);
    final result = await dbController.getProducts(listId);
    emit(ProductListState(
        dataState: DataProcessingState.dataAccessed, productListData: result));
  }

  Future<void> deleteProduct(int index) async {
    dbController.deleteProduct(index);
    final result = await dbController.getProducts(listId);
    emit(ProductListState(
        dataState: DataProcessingState.dataAccessed, productListData: result));
  }

  Future<void> updateProductName(int id, String name) async {
    dbController.updateProductName(id, name);
    final result = await dbController.getProducts(listId);
    emit(ProductListState(
        dataState: DataProcessingState.dataAccessed, productListData: result));
  }

  Future<void> updateProductCheck(int id, newValue) async {
    await dbController.updateProductCheck(id, newValue == true ? 1 : 0);
    final result = await dbController.getProducts(listId);
    emit(ProductListState(
        dataState: DataProcessingState.dataAccessed, productListData: result));
  }
}