import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_368/data/model/todo_model.dart';

class DbHelper {
  DbHelper._();

  static DbHelper getInstance() => DbHelper._();

  static String TABLE_TODO = "todo";
  static String COLUMN_TODO_ID = "t_id"; //auto increment
  static String COLUMN_TODO_TITLE = "t_title";
  static String COLUMN_TODO_DESC = "t_desc";
  static String COLUMN_TODO_IS_COMPLETED = "t_is_completed";
  static String COLUMN_TODO_CREATED_AT = "t_created_at";

  Database? mDb;

  Future<Database> getDb() async {
    mDb ??= await openDB();

    return mDb!;
  }

  Future<Database> openDB() async {
    String path =
        join((await getApplicationDocumentsDirectory()).path, "todoDB.db");

    return await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          "Create table $TABLE_TODO ( $COLUMN_TODO_ID integer primary key autoincrement, $COLUMN_TODO_TITLE text, $COLUMN_TODO_DESC text, $COLUMN_TODO_IS_COMPLETED integer, $COLUMN_TODO_CREATED_AT text )");
    });
  }

  Future<bool> addTodo(TodoModel newTodo) async {
    var db = await getDb();

    int rowsEffected = await db.insert(TABLE_TODO, newTodo.toMap());

    return rowsEffected > 0;
  }

  Future<List<TodoModel>> fetchAllTodo() async {
    var db = await getDb();
    List<Map<String, dynamic>> mData = await db.query(TABLE_TODO);

    List<TodoModel> allTodo = [];

    for (Map<String, dynamic> eachTodo in mData) {
      allTodo.add(TodoModel.fromMap(eachTodo));
    }

    return allTodo;
  }

  Future<bool> updateTodo(bool isCompleted, int id) async {
    var db = await getDb();

    int rowsEffected = await db.update(TABLE_TODO, {COLUMN_TODO_IS_COMPLETED : isCompleted ? 1 : 0},
        where: "$COLUMN_TODO_ID = ?", whereArgs: ["$id"]);

    return rowsEffected > 0;
  }
}
