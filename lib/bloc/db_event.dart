import 'package:todo_app_368/data/model/todo_model.dart';

abstract class DBEvent{}


class AddTodoEvent extends DBEvent{
  TodoModel newTodo;
  AddTodoEvent({required this.newTodo});
}
class GetInitialTodoEvent extends DBEvent{}
class CompleteTodoEvent extends DBEvent{
  bool isCompleted;
  int id;
  CompleteTodoEvent({required this.isCompleted, required this.id});
}
class UpdateTodoEvent extends DBEvent{
  TodoModel updatedModel;
  UpdateTodoEvent({required this.updatedModel});
}
class DeleteTodoEvent extends DBEvent{
  int id;
  DeleteTodoEvent({required this.id});
}




