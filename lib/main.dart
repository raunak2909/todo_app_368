import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_368/bloc/db_bloc.dart';
import 'package:todo_app_368/data/local/db_helper.dart';
import 'package:todo_app_368/provider/db_provider.dart';
import 'package:todo_app_368/ui/home_page.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => DBBloc(dbHelper: DbHelper.getInstance()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
