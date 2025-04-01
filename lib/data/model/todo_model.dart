import '../local/db_helper.dart';

class TodoModel{
  int? id;
  String title;
  String desc;
  String createdAt;
  bool isCompleted;

  TodoModel({
    this.id,
    required this.title,
    required this.desc,
    required this.createdAt,
    required this.isCompleted
  });

  Map<String, dynamic> toMap() {
    return {
      DbHelper.COLUMN_TODO_ID : id,
      DbHelper.COLUMN_TODO_TITLE: title,
      DbHelper.COLUMN_TODO_DESC: desc,
      DbHelper.COLUMN_TODO_CREATED_AT: createdAt,
      DbHelper.COLUMN_TODO_IS_COMPLETED: isCompleted==true ? 1 : 0
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map[DbHelper.COLUMN_TODO_ID],
      title: map[DbHelper.COLUMN_TODO_TITLE],
      desc: map[DbHelper.COLUMN_TODO_DESC],
      createdAt: map[DbHelper.COLUMN_TODO_CREATED_AT],
      isCompleted: map[DbHelper.COLUMN_TODO_IS_COMPLETED]==1 ? true : false
    );
  }


}