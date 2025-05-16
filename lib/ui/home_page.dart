import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_368/bloc/db_bloc.dart';
import 'package:todo_app_368/bloc/db_event.dart';
import 'package:todo_app_368/bloc/db_state.dart';
import 'package:todo_app_368/data/local/db_helper.dart';
import 'package:todo_app_368/data/model/todo_model.dart';
import 'package:todo_app_368/provider/db_provider.dart';
import 'package:todo_app_368/ui/add_todo_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> mTodo = [];

  @override
  void initState() {
    super.initState();
    context.read<DBBloc>().add(GetInitialTodoEvent());

    ///getAllTodo();
  }

  /*void getAllTodo() async {
    mTodo = await dbHelper.fetchAllTodo();
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: BlocBuilder<DBBloc, DBState>(builder: (_, state) {
        if (state is DBLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is DBErrorState) {
          return Center(
            child: Text("Error: ${state.errorMsg}"),
          );
        }

        if (state is DBLoadedState) {
          mTodo = state.mTodos;
          return ListView.builder(
              itemCount: mTodo.length,
              itemBuilder: (_, index) {
                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: mTodo[index].isCompleted,
                  onChanged: (value) async {
                    /*bool check = await dbHelper.completeTask(value ?? false, mTodo[index].id!);
            if(check){
              getAllTodo();
            }*/

                    context.read<DBBloc>().add(CompleteTodoEvent(
                        isCompleted: value ?? false, id: mTodo[index].id!));
                    /*context
                        .read<DBProvider>()
                        .updateStatus(value ?? false, mTodo[index].id!);*/
                  },
                  title: Text(
                    mTodo[index].title,
                    style: TextStyle(
                        decoration: mTodo[index].isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  subtitle: Text(
                    mTodo[index].desc,
                    style: TextStyle(
                        decoration: mTodo[index].isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  secondary: IconButton(
                      onPressed: () {
                        context.read<DBProvider>().deleteTodo(mTodo[index].id!);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                );
              });
        }

        return Container();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTodoPage(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
