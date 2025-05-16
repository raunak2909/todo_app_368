import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_368/bloc/db_bloc.dart';
import 'package:todo_app_368/bloc/db_event.dart';
import 'package:todo_app_368/data/local/db_helper.dart';
import 'package:todo_app_368/provider/db_provider.dart';

import '../data/model/todo_model.dart';

class AddTodoPage extends StatelessWidget {
  DbHelper dbHelper = DbHelper.getInstance();
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                hintText: 'Title',
              ),
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                hintText: 'Description',
                focusedBorder: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            ElevatedButton(
                onPressed: () async {
                  context
                      .read<DBBloc>()
                      .add(AddTodoEvent(newTodo: TodoModel(
                          title: titleController.text,
                          desc: descController.text,
                          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                          isCompleted: false))
                  );

                  Navigator.pop(context);

                  /*bool check = await dbHelper.addTodo(TodoModel(
                  title: titleController.text,
                  desc: descController.text,
                  createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                  isCompleted: false));

              if(check){
                Navigator.pop(context);
              }*/
                },
                child: Text('Add Todo'))
          ],
        ),
      ),
    );
  }
}
