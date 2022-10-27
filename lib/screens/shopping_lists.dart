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
    return BlocProvider(
      create: (bloc_context) => ShoppingListCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Choose your list!'),
        ),
        body: BlocConsumer<ShoppingListCubit, ShoppingListState>(
          listener: (context, state) {
            print(state.dataState);
          },
          builder: (context, state) {
            BlocProvider.of<ShoppingListCubit>(context).getData();
            switch (state.dataState) {
              case DataProcessingState.fetchingData:
                {
                  return const Center(child: CircularProgressIndicator());
                }
              case DataProcessingState.dataAccessed:
                {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: BlocProvider.of<ShoppingListCubit>(context)
                        .ShoppingListData
                        .length,
                    itemBuilder: (new_context, index) {
                      return MyTile(
                          BlocProvider.of<ShoppingListCubit>(context)
                              .ShoppingListData[index]
                              .title,
                          BlocProvider.of<ShoppingListCubit>(context)
                              .ShoppingListData[index]
                              .id!,
                          _deleteNote,
                          key: UniqueKey());
                    },
                  );
                }
              case DataProcessingState.idle:
                {
                  return const Icon(Icons.air_rounded, size: 60);
                }
              case DataProcessingState.noConnection:
                {
                  return Title(
                      title: "No Internet Connection!",
                      color: Colors.red,
                      child: const Icon(
                        Icons
                            .signal_cellular_connected_no_internet_0_bar_rounded,
                        size: 60,
                        color: Colors.red,
                      ));
                }
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              BlocProvider.of<ShoppingListCubit>(context).addList(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _deleteNote(int index) async {
    await dbController.deleteShoppingList(index);
    setState(() {});
  }
}