import 'package:flutter/material.dart';
import 'package:todo_app_368/data/local/db_helper.dart';
import 'package:todo_app_368/data/model/todo_model.dart';

class DBProvider extends ChangeNotifier{
  DbHelper dbHelper;
  DBProvider({required this.dbHelper});

  List<TodoModel> _mTodo = [];

  ///events
  void addTodo(TodoModel todoModel) async{
    bool check = await dbHelper.addTodo(todoModel);

    if(check){
      _mTodo = await dbHelper.fetchAllTodo();
      notifyListeners();
    }

  }

  void updateStatus(bool isCompleted, int id) async{
    bool check = await dbHelper.completeTask(isCompleted, id);
    if(check){
      _mTodo = await dbHelper.fetchAllTodo();
      notifyListeners();
    }
  }

  void deleteTodo(int id) async{
    bool check =await dbHelper.deleteTodo(id);

    if(check){
      _mTodo = await dbHelper.fetchAllTodo();
      notifyListeners();
    }

  }

  List<TodoModel> getData() => _mTodo;

  void getInitialData() async{
    _mTodo = await dbHelper.fetchAllTodo();
    notifyListeners();
  }

  ///update
  ///delete


}