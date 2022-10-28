import 'package:flutter/material.dart';
import 'package:to_do_flutter/data/database_controller.dart';
import 'package:to_do_flutter/data/shopping_list_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/shopping_list_tile.dart';
import '../shopping_list_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseController dbController = DatabaseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your list!'),
      ),
      body: BlocBuilder<ShoppingListCubit, ShoppingListState>(
        builder: (context, state) {
          switch (state.dataState) {
            case DataProcessingState.fetchingData:
              return const Center(child: CircularProgressIndicator());
            case DataProcessingState.dataAccessed:
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: state.shoppingListData.length,
                itemBuilder: (context, index) {
                  return MyTile(state.shoppingListData[index].title,
                      state.shoppingListData[index].id!,
                      key: UniqueKey());
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
        onPressed: () => context.read<ShoppingListCubit>().addList(),
        child: const Icon(Icons.add),
      ),
    );
  }
}