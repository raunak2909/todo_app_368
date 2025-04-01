import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_368/data/local/db_helper.dart';
import 'package:todo_app_368/data/model/todo_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper.getInstance();
  List<TodoModel> mTodo = [];

  @override
  void initState() {
    super.initState();
    getAllTodo();
  }

  void getAllTodo() async {
    mTodo = await dbHelper.fetchAllTodo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: ListView.builder(
        itemCount: mTodo.length,
          itemBuilder: (_, index) {
        return CheckboxListTile(
          value: mTodo[index].isCompleted,
          onChanged: (value) async{
            bool check = await dbHelper.updateTodo(value ?? false, mTodo[index].id!);
            if(check){
              getAllTodo();
            }
          },
          title: Text(mTodo[index].title),
          subtitle: Text(mTodo[index].desc),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          bool check = await dbHelper.addTodo(TodoModel(
              title: "My Work",
              desc: "Complete todo app today!!",
              createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
              isCompleted: false));

          if(check){
            getAllTodo();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
