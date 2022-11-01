import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_flutter/bloc/product_list_cubit.dart';
import '../data/shopping_list_data.dart';
import '../widgets/product.dart';

class MyProductList extends StatefulWidget {
  const MyProductList({Key? key}) : super(key: key);

  @override
  State createState() => _ProductListState();
}

class _ProductListState extends State<MyProductList> {
  @override
  Widget build(BuildContext context) {
    final listId = context.read<ProductListCubit>().listId;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new products'),
      ),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
          switch (state.dataState) {
            case DataProcessingState.fetchingData:
              return const Center(child: CircularProgressIndicator());
            case DataProcessingState.dataAccessed:
              return ListView.builder(
                itemCount: state.productListData.length,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  return ProductController(
                    product: state.productListData[index],
                    key: UniqueKey(),
                  );
                },
              );
            case DataProcessingState.idle:
              return const Icon(Icons.air_rounded, size: 60);
            case DataProcessingState.noConnection:
              return Title(
                  title: "No Internet Connection!",
                  color: Colors.red,
                  child: const Icon(
                    Icons.signal_cellular_connected_no_internet_0_bar_rounded,
                    size: 60,
                    color: Colors.red,
                  ));
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context
            .read<ProductListCubit>()
            .addProduct(ProductData(listId: listId, name: "", isChecked: 0)),
        child: const Icon(Icons.add),
      ),
    );
  }
}