import '../local/db_helper.dart';

class TodoModel {
  int? id;
  String title;
  String desc;
  bool isCompleted;
  String createdAt;

  TodoModel(
      {this.id,
      required this.title,
      required this.desc,
      required this.isCompleted,
      required this.createdAt});

  factory TodoModel.fromMap(Map<String, dynamic> map){
    return TodoModel(
        id: map[DbHelper.COLUMN_TODO_ID],
        title: map[DbHelper.COLUMN_TODO_TITLE],
        desc: map[DbHelper.COLUMN_TODO_DESC],
        isCompleted: map[DbHelper.COLUMN_TODO_IS_COMPLETED] == 1 ? true : false,
        createdAt: map[DbHelper.COLUMN_TODO_CREATED_AT]);
  }



  Map<String, dynamic> toMap() {
    return {
      DbHelper.COLUMN_TODO_TITLE: title,
      DbHelper.COLUMN_TODO_DESC: desc,
      DbHelper.COLUMN_TODO_IS_COMPLETED: isCompleted ? 1 : 0,
      DbHelper.COLUMN_TODO_CREATED_AT: createdAt
    };
  }

}
