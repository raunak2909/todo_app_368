import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_368/bloc/db_event.dart';
import 'package:todo_app_368/bloc/db_state.dart';
import 'package:todo_app_368/data/local/db_helper.dart';
import 'package:todo_app_368/data/model/todo_model.dart';

class DBBloc extends Bloc<DBEvent, DBState>{
  DbHelper dbHelper;
  DBBloc({required this.dbHelper}) : super(DBInitialState()){

    on<AddTodoEvent>((event, emit) async{

      emit(DBLoadingState());

      bool check = await dbHelper.addTodo(event.newTodo);

      if(check){
        List<TodoModel> allTodo = await dbHelper.fetchAllTodo();
        emit(DBLoadedState(mTodos: allTodo));
      } else {
        emit(DBErrorState(errorMsg: "Something went wrong, Todo not added!!"));
      }

    });

    on<GetInitialTodoEvent>((event, emit) async{

      emit(DBLoadingState());

      List<TodoModel> allTodo = await dbHelper.fetchAllTodo();
      emit(DBLoadedState(mTodos: allTodo));
    });

    on<CompleteTodoEvent>((event, emit) async{

      emit(DBLoadingState());

      bool check = await dbHelper.completeTask(event.isCompleted, event.id);

      if(check) {
        var allTodo = await dbHelper.fetchAllTodo();
        emit(DBLoadedState(mTodos: allTodo));
      } else {
        emit(DBErrorState(errorMsg: "Something went wrong, Todo not updated!!"));

      }
    });


  }

}