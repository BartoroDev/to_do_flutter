part of 'product_list_cubit.dart';

class ProductListState {
  final DataProcessingState dataState;
  final List<ProductData> productListData;

  ProductListState(
      {this.dataState = DataProcessingState.idle,
      this.productListData = const []});
}