import 'package:todo_app_368/data/model/todo_model.dart';

abstract class DBState{}

class DBInitialState extends DBState{}

class DBLoadingState extends DBState{}

class DBLoadedState extends DBState{
  List<TodoModel> mTodos;
  DBLoadedState({required this.mTodos});
}

class DBErrorState extends DBState{
  String errorMsg;
  DBErrorState({required this.errorMsg});
}