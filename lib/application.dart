import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_flutter/data/database_controller.dart';
import 'package:to_do_flutter/screens/shopping_lists.dart';
import 'package:to_do_flutter/bloc/shopping_list_cubit.dart';

Future<void> _initDatabase() async => DatabaseController().init();

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initDatabase();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: BlocProvider(
        create: (context) => ShoppingListCubit()..getData(),
        child: const HomePage(),
      ),
    );
  }
}